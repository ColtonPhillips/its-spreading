extends Node

func _ready():
	self.visible = false

func pause():
	get_tree().paused = true
	self.visible = true

func unpause():
	get_tree().paused = false
	self.visible = false

func _on_exit_to_menu_button_pressed():
	unpause()
	get_tree().change_scene_to_file("res://scenes/gui/main_menu/main_menu.tscn")

func _on_unpause_button_pressed():
	unpause()

func _input(event):
	if Input.is_action_just_pressed("pause"):
		print('pause')
		unpause() if get_tree().paused else pause()
