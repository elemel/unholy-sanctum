extends StaticBody2D
class_name Rock

func _process(_delta: float) -> void:
    z_index = int(position.y)
