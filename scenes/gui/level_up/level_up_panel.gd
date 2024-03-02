extends CanvasLayer
class_name LevelUpPanel
@export var item_option: PackedScene
@onready var upgrade_options: VBoxContainer  = $Panel/UpgradeOptions
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $Panel/AudioStreamPlayer2D

func _ready():
	var options := 0
	var options_max := 3
	while options < options_max:
		var option_choice : LevelUpOption = item_option.instantiate()
		upgrade_options.add_child(option_choice)
		options += 1
		
	#upgrade_options.get_child(0).focus_neighbor_bottom = upgrade_options.get_child(1).get_path()

func _on_visibility_changed():
	if is_instance_valid(upgrade_options) and upgrade_options.get_child_count() > 0:
		(upgrade_options.get_child(0) as Control).grab_focus()
	if visible == true:
		audio_stream_player_2d.play()

func set_options(prize_options):
	var i := 0
	for option in upgrade_options.get_children():
		option.title.text = prize_options[i].title
		option.description.text = prize_options[i].description
		option.item = prize_options[i]
		i += 1
		
	
