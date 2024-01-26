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

func set_options(prize_options):
	var i = 0
	for option in upgrade_options.get_children():
		option.title.text = prize_options[i].title
		option.description.text = prize_options[i].description
		option.item = prize_options[i]
		i += 1
