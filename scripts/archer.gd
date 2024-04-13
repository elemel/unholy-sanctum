extends CharacterBody2D

@export var acceleration = 200.0
@export var speed = 100.0
@export var range = 100.0

func _ready():
    motion_mode = CharacterBody2D.MOTION_MODE_FLOATING

func _physics_process(delta):
    var direction = Vector2.ZERO
    var target = Vector2.ZERO

    if position.distance_to(target) > range:
        direction = (target - position).normalized()

    velocity = velocity.move_toward(speed * direction, acceleration * delta)
    move_and_slide()
