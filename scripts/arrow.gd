extends Area2D
class_name Arrow

@export var speed = 100.0
@export var life_duration = 3.0

var creation_time = 0.0
var velocity = Vector2.ZERO

func _ready():
    creation_time = 0.001 * Time.get_ticks_msec()
    body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
    var now = 0.001 * Time.get_ticks_msec()

    if now - creation_time > life_duration:
        queue_free()
        return

    position += velocity * delta

func _on_body_entered(body: Node2D):
    print(body)
