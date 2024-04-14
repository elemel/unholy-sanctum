extends Node2D

@export var music_screen_file = "res://scenes/screens/music.tscn"
@export var title_screen_file = "res://scenes/screens/title.tscn"

func _ready():
    start_screen.call_deferred(music_screen_file)
    start_screen.call_deferred(title_screen_file)

func start_screen(screen_file: String) -> void:
    var screen_scene: PackedScene = load(screen_file)
    var screen = screen_scene.instantiate()
    get_tree().root.add_child(screen)
