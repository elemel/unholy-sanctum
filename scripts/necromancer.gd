extends CharacterBody2D
class_name Necromancer

@export var acceleration = 200.0
@export var speed = 100.0
@export var spring_stiffness = 10.0
@export var spring_damping = 1.0

@onready var sprite = $"Sprite2D"

func _physics_process(delta):
    var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
    velocity = velocity.move_toward(speed * direction, acceleration * delta)

    z_index = int(position.y)

    if direction.x < -0.5:
        sprite.scale.x = -1
    elif direction.x > 0.5:
        sprite.scale.x = 1

    move_and_slide()
