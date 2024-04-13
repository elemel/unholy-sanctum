extends CharacterBody2D
class_name Peasant

@export var acceleration = 100.0
@export var speed = 50.0
@export var fire_range = 100.0
@export var torch_scene: PackedScene
@export var reload_duration = 1.0

var fire_time = 0.0

@onready var sprite = $"Sprite2D"

func _physics_process(delta):
    var move_direction = Vector2.ZERO
    var target = find_target()

    if target != null:
        var target_distance = position.distance_to(target.position)
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

        if move_direction.x < -0.5:
            sprite.scale.x = -1
        elif move_direction.x > 0.5:
            sprite.scale.x = 1

    velocity = velocity.move_toward(speed * move_direction, acceleration * delta)
    move_and_slide()
    z_index = int(position.y)

func find_target():
    var target = null
    var min_distance = INF

    for unit in get_parent().get_children():
        if unit is Altar or unit is Necromancer:
            var distance = position.distance_to(unit.position)

            if distance < min_distance:
                min_distance = distance
                target = unit

    return target
