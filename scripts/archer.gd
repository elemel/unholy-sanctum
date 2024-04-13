extends CharacterBody2D
class_name Archer

@export var acceleration = 200.0
@export var speed = 100.0
@export var fire_range = 100.0
@export var arrow_scene: PackedScene
@export var reload_duration = 1.0

var fire_time = 0.0

func _physics_process(delta):
    var target = Vector2.ZERO
    var target_distance = position.distance_to(target)
    var target_direction = (target - position).normalized()
    var move_direction = Vector2.ZERO

    if target_distance > fire_range:
        move_direction = target_direction
    else:
        var now = 0.001 * Time.get_ticks_msec()

        if arrow_scene != null and now > fire_time + reload_duration:
            fire_time = now

            var arrow: Arrow = arrow_scene.instantiate()
            arrow.position = position
            arrow.velocity = arrow.speed * target_direction

            get_parent().add_child(arrow)

    velocity = velocity.move_toward(speed * move_direction, acceleration * delta)
    move_and_slide()
