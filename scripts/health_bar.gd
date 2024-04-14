extends Node2D

@onready var unit: Node2D = get_parent()
@onready var background_panel: Panel = get_node("Background")
@onready var foreground_panel: Panel = background_panel.get_node("Foreground")

func _ready():
    update_visible()

func _process(_delta: float) -> void:
    update_visible()
    var health_fraction = unit.current_health / unit.max_health
    foreground_panel.size.x = background_panel.size.x * health_fraction

func update_visible() -> void:
    var healthy = (unit.current_health / unit.max_health) >= 0.999
    background_panel.visible = not healthy
