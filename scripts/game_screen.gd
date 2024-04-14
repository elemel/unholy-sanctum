extends Node2D

@export var title_screen_file = "res://scenes/screens/title.tscn"

func _input(event: InputEvent) -> void:
    if event is InputEventKey:
        if event.pressed and (event.keycode == KEY_ESCAPE or event.keycode == KEY_BACKSPACE):
            quit_game()

func quit_game() -> void:
    var title_screen_scene = load(title_screen_file)
    get_tree().root.add_child(title_screen_scene.instantiate())
    get_tree().root.remove_child(self)
