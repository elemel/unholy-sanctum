extends Label
class_name TimerLabel

@export var you_win_screen_file = "res://scenes/screens/you_win.tscn"

var timeout_duration = 60.0

@onready var game: Game = get_node("../../..")
@onready var creation_time = 0.001 * Time.get_ticks_msec()

func _physics_process(_delta: float) -> void:
    if get_remaining_duration() <= 0.0:
        switch_to_screen(you_win_screen_file)

func _process(_delta: float) -> void:
    var remaining_duration = get_remaining_duration()

    var seconds = posmod(floori(remaining_duration), 60)
    var minutes = posmod(floori(remaining_duration / 60.0), 60)

    text = "%02d:%02d" % [minutes, seconds]

func get_remaining_duration() -> float:
    var now = 0.001 * Time.get_ticks_msec()
    var elapsed_duration = now - creation_time
    return timeout_duration - elapsed_duration

func switch_to_screen(screen_file: String) -> void:
    var screen_scene: PackedScene = load(screen_file)
    var screen = screen_scene.instantiate()
    get_tree().root.add_child(screen)
    get_tree().root.remove_child(game)
