extends CharacterBody2D
class_name Peasant

@export var acceleration = 100.0
@export var speed = 50.0
@export var fire_range = 100.0
@export var torch_scene: PackedScene
@export var reload_duration = 1.0
@export var unit_radius = 10.0

var fire_time = 0.0
var face_direction = 1

@onready var sprite = $"Sprite2D"
@onready var shadow_sprite = $"Shadow/Sprite2D"

func _physics_process(delta: float) -> void:
    var move_direction = Vector2.ZERO
    var target = find_target()

    if target != null:
        var target_distance = position.distance_to(target.position) - unit_radius - target.unit_radius
        var target_direction = (target.position - position).normalized()

        if target_distance > fire_range:
            move_direction = target_direction
        else:
            var now = 0.001 * Time.get_ticks_msec()

            if torch_scene != null and now > fire_time + reload_duration:
                fire_time = now

                var torch: Torch = torch_scene.instantiate()
                torch.position = position
                torch.velocity = torch.speed * target_direction
                torch.thrower = self

                get_parent().add_child(torch)

        if target_direction.x < 0.0:
            face_direction = -1
        elif target_direction.x > 0.0:
            face_direction = 1

    velocity = velocity.move_toward(speed * move_direction, acceleration * delta)
    move_and_slide()

func _process(_delta: float) -> void:
    sprite.scale.x = float(face_direction)
    shadow_sprite.scale.x = float(face_direction)

    z_index = int(position.y)

func find_target() -> Node2D:
    var target = null
    var min_distance = INF

    for node in get_parent().get_children():
        if node is Altar or node is Necromancer or node is Blob:
            var distance = position.distance_to(node.position) - unit_radius - node.unit_radius

            if distance < min_distance:
                min_distance = distance
                target = node

    return target
