extends StaticBody2D
class_name Altar

@export var health = 200.0
@export var unit_radius = 15.0

func _process(_delta):
    z_index = int(position.y)

func receive_damage(damage: float):
    health -= damage

    if health < 0.0:
        queue_free()
