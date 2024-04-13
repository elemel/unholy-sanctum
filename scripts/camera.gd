extends Camera2D
class_name Camera

func _process(_delta: float) -> void:
    var target = find_target()

    if target != null:
        position = target.position

func find_target() -> Node2D:
    for unit in get_parent().get_children():
        if unit is Necromancer:
            return unit

    return null
