extends Node2D

@export var title_screen_file = "res://scenes/screens/title.tscn"

func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        if event.pressed:
            switch_to_screen(title_screen_file)

    if event is InputEventKey:
        if event.pressed:
            switch_to_screen(title_screen_file)

func switch_to_screen(screen_file: String) -> void:
    var screen_scene: PackedScene = load(screen_file)
    var screen = screen_scene.instantiate()
    get_tree().root.add_child(screen)
    get_tree().root.remove_child(self)
