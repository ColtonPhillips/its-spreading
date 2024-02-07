extends CanvasLayer

@export var start_game_scene: String
@export var credits_scene: String
@export var back_scene: String

func _enter_tree():
	if not GlobalSound.is_playing:
		GlobalSound.play()
	#$Fader.play('fade_in')

func _on_start_game_link_pressed():
	get_tree().change_scene_to_file(start_game_scene)
	GlobalSound.stop()

func _on_credits_link_pressed():
	#get_tree().change_scene_to_file(credits_scene)
	get_tree().change_scene_to_file(credits_scene)
	GlobalSound.stop()	

func _on_exit_link_pressed():
	GlobalSound.stop()	
	get_tree().quit();


func _on_check_button_toggled(toggled_on):
	if toggled_on:
		Global.Toggle_Fullscreen_On()
	else:
		Global.Toggle_Fullscreen_Off()


func _on_back_link_pressed():
	get_tree().change_scene_to_file(back_scene)
