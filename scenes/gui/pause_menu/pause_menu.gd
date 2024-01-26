class_name PauseMenu
extends Node

@export var main_menu_scene: Resource
@onready var level_up_panel = $"../LevelUpPanel"

func _ready():
	self.visible = false

func pause():
	Global.player.process_mode = Node.PROCESS_MODE_DISABLED
	$Fader.play('pause_fade_in')
	get_tree().paused = true
	self.visible = true

func unpause():
	Global.player.process_mode = Node.PROCESS_MODE_ALWAYS	
	$Fader.play('pause_fade_out')

### UI BUTTONS
func _on_exit_to_menu_button_pressed():
	$Fader.play('fade_to_black_for_main_menu')

func _on_unpause_button_pressed():
	unpause()

### EVENTS
func _input(event):
	if level_up_panel.visible == true:
		return
	if Input.is_action_just_pressed("pause"):
		unpause() if get_tree().paused else pause()


func _on_fader_animation_finished(anim_name):
	if anim_name == 'pause_fade_out':
		get_tree().paused = false
		self.visible = false
	elif anim_name == 'fade_to_black_for_main_menu':
		get_tree().paused = false

		# For some reason the exported variable resolves to null. I think it has to do with the way 
		# the scene is instanced(?) but I'm tired
		get_tree().change_scene_to_file('res://scenes/gui/main_menu/main_menu.tscn')
		
