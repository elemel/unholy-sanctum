extends StaticBody2D
class_name Altar

@export var max_health = 200.0
@export var current_health = 200.0
@export var unit_radius = 15.0

func _process(_delta: float) -> void:
    z_index = int(position.y)

func receive_damage(damage: float) -> void:
    current_health -= damage

    if current_health < 0.0:
        queue_free()
