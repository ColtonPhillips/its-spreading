extends Node
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var is_playing = true
func play():
	is_playing = true
	audio_stream_player_2d.play()
func stop():
	is_playing = false
	audio_stream_player_2d.stop()
