extends CanvasLayer
class_name LevelUpPanel
@export var item_option: PackedScene
@onready var upgrade_options = $Panel/UpgradeOptions
@onready var audio_stream_player_2d = $Panel/AudioStreamPlayer2D

func _ready():
	var options = 0
	var options_max = 3
	while options < options_max:
		var option_choice = item_option.instantiate()
		upgrade_options.add_child(option_choice)
		options += 1


func _on_visibility_changed():
	if visible == true:
		audio_stream_player_2d.play()
