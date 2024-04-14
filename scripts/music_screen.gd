extends Node2D

@onready var audio_stream_player: AudioStreamPlayer = get_node("AudioStreamPlayer")

func _ready():
    audio_stream_player.play()
