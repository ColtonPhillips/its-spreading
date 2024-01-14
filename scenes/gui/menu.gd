#class_name Menu
extends Control

func pause():
	get_tree().paused = true
	self.visible = true
	
func unpause():
	get_tree().paused = false
	self.visible = false
	
func toggle_pause():
	get_tree().paused = not get_tree().paused
	self.visible = not self.visible

func _ready():
	pause()

func _input(event):
	if Input.is_action_just_pressed("pause"):
		toggle_pause()

func _on_exit_pressed():
		get_tree().quit();

func _on_unpause_pressed():
	unpause()
