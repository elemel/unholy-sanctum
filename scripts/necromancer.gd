extends CharacterBody2D

@export var acceleration = 200.0
@export var speed = 100.0

func _ready():
    motion_mode = CharacterBody2D.MOTION_MODE_FLOATING

func _physics_process(delta):
    var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
    velocity = velocity.move_toward(speed * direction, acceleration * delta)
    move_and_slide()
