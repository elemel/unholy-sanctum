extends CharacterBody2D
class_name Necromancer

@export var acceleration = 200.0
@export var speed = 100.0
@export var spring_stiffness = 10.0
@export var spring_damping = 1.0
@export var unit_radius = 15.0

@onready var sprite = $"Sprite2D"
@onready var shadow_sprite = $"Shadow/Sprite2D"

var face_direction = 1

func _physics_process(delta: float) -> void:
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
