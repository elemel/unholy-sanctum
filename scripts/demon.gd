extends CharacterBody2D
class_name Demon

@export var acceleration = 100.0
@export var speed = 50.0
@export var attack_range = 30.0
@export var attack_cooldown = 2.0
@export var unit_radius = 15.0
@export var max_health = 100.0
@export var current_health = 100.0
@export var min_damage = 20.0
@export var max_damage = 50.0

var attack_time = 0.0
var face_direction = 1

@onready var sprite = $"Sprite2D"
@onready var shadow_sprite = $"Shadow/Sprite2D"

func _physics_process(delta: float) -> void:
    if current_health < 0.0:
        queue_free()
        return

    var move_direction = Vector2.ZERO
    var target = find_target()

    if target != null:
        var target_distance = position.distance_to(target.position) - unit_radius - target.unit_radius
        var target_direction = (target.position - position).normalized()

        if target_distance > attack_range:
            move_direction = target_direction
        else:
            var now = 0.001 * Time.get_ticks_msec()

            if now > attack_time + attack_cooldown:
                attack_time = now

                if target.has_method("receive_damage"):
                    var damage = randf_range(min_damage, max_damage)
                    target.receive_damage(damage)

        if target_direction.x < 0.0:
            face_direction = -1
        elif target_direction.x > 0.0:
            face_direction = 1

    velocity = velocity.move_toward(speed * move_direction, acceleration * delta)
    move_and_slide()

func _process(_delta: float) -> void:
    var now = 0.001 * Time.get_ticks_msec()
    var animated_scale = Vector2.ONE
    var animated_rotation = 0.0

    var duration_since_attack = now - attack_time
    animated_rotation += face_direction * 0.25 * PI * smoothstep(0.125, 0.0, abs(0.125 - duration_since_attack))

    animated_scale.x *= float(face_direction)

    sprite.scale = animated_scale
    sprite.rotation = animated_rotation

    shadow_sprite.scale = animated_scale
    shadow_sprite.rotation = animated_rotation

    z_index = int(position.y)

func find_target() -> Node2D:
    var target = null
    var min_distance = INF

    for node in get_parent().get_children():
        if node is Peasant:
            var distance = position.distance_to(node.position) - unit_radius - node.unit_radius

            if distance < min_distance:
                min_distance = distance
                target = node

    return target

func receive_damage(damage: float) -> void:
    current_health -= damage
