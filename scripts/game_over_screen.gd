extends Node2D

@export var title_screen_file = "res://scenes/screens/title.tscn"
@export var delay = 2.0

var start_time = 0.0

@onready var press_any_key_label: Label = get_node("PressAnyKey")

func _ready() -> void:
    start_time = 0.001 * Time.get_ticks_msec()
    press_any_key_label.visible = false

func _process(_delta: float) -> void:
    press_any_key_label.visible = is_delay_done()

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        if event.pressed:
            if is_delay_done():
                get_viewport().set_input_as_handled()
                switch_to_screen(title_screen_file)

    if event is InputEventKey:
        if event.pressed:
            if is_delay_done():
                get_viewport().set_input_as_handled()
                switch_to_screen(title_screen_file)

func is_delay_done() -> bool:
    var now = 0.001 * Time.get_ticks_msec()
    return now > start_time + delay

func switch_to_screen(screen_file: String) -> void:
    var screen_scene: PackedScene = load(screen_file)
    var screen = screen_scene.instantiate()
    get_tree().root.add_child(screen)
    get_tree().root.remove_child(self)
