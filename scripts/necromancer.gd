extends Unit
class_name Necromancer

@export var acceleration = 200.0
@export var speed = 100.0

var velocity = Vector2.ZERO

func _physics_process(delta):
    var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
    velocity = velocity.move_toward(speed * direction, acceleration * delta)
    position += velocity * delta
