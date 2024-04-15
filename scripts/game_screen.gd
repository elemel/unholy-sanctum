extends Node2D
class_name Game

@export var title_screen_file = "res://scenes/screens/title.tscn"
@export var game_over_screen_file = "res://scenes/screens/game_over.tscn"
@export var game_over_delay = 2.0

var game_over = false
var game_over_time = 0.0

@onready var game_over_stream_player = get_node("GameOverStreamPlayer")

func _physics_process(_delta: float) -> void:
    var now = 0.001 * Time.get_ticks_msec()

    if game_over:
        if now > game_over_time + game_over_delay:
            switch_to_screen(game_over_screen_file)
    else:
        game_over = is_game_over()

        if game_over:
            game_over_time = now
            game_over_stream_player.play()

func _unhandled_key_input(event: InputEvent) -> void:
    if event is InputEventKey:
        if event.pressed and (event.keycode == KEY_ESCAPE or event.keycode == KEY_BACKSPACE):
            get_viewport().set_input_as_handled()
            switch_to_screen(title_screen_file)

func switch_to_screen(screen_file: String) -> void:
    var screen_scene: PackedScene = load(screen_file)
    var screen = screen_scene.instantiate()
    get_tree().root.add_child(screen)
    get_tree().root.remove_child(self)

func is_game_over() -> bool:
    var altar_count = 0
    var necromancer_count = 0

    for node in get_children():
        if node is Altar:
            altar_count += 1

        if node is Necromancer:
            necromancer_count += 1

    return altar_count == 0 or necromancer_count == 0
