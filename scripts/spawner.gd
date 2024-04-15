extends Node2D
class_name Spawner

@export var unit_scene: PackedScene
@export var min_distance = 0.0
@export var max_distance = 0.0

var unit: Node2D
var spawn_time = 0.0

func _physics_process(_delta: float) -> void:
    if unit == null or not unit.is_inside_tree():
        if unit_scene != null:
            unit = unit_scene.instantiate()
            unit.position = generate_position()
            get_parent().add_child(unit)

func generate_position() -> Vector2:
    var distance = randf_range(min_distance, max_distance)
    var direction = generate_direction()
    return position + distance * direction

func generate_direction() -> Vector2:
    var angle = randf() * 2 * PI
    return Vector2(cos(angle), sin(angle))
