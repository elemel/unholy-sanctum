extends CharacterBody2D
class_name Necromancer

@export var acceleration = 200.0
@export var speed = 100.0
@export var spring_stiffness = 10.0
@export var spring_damping = 1.0
@export var unit_radius = 15.0
@export var max_health = 100.0
@export var current_health = 100.0
@export var blob_scene: PackedScene
@export var blob_cost = 30.0

@onready var sprite = $"Sprite2D"
@onready var shadow_sprite = $"Shadow/Sprite2D"

var face_direction = 1

func _physics_process(delta: float) -> void:
    if current_health < 0.0:
        queue_free()
        return

    var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
    velocity = velocity.move_toward(speed * direction, acceleration * delta)

    if direction.x < -0.5:
        face_direction = -1
    elif direction.x > 0.5:
        face_direction = 1

    move_and_slide()

func _process(_delta: float) -> void:
    sprite.scale.x = float(face_direction)
    shadow_sprite.scale.x = float(face_direction)

    z_index = int(position.y)

func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        if event.pressed:
            var game: Game = get_parent()
            var attack_position = game.get_local_mouse_position()

            var blob = blob_scene.instantiate()
            blob.position = attack_position
            game.add_child(blob)

            current_health -= blob_cost

func receive_damage(damage: float) -> void:
    current_health -= damage
