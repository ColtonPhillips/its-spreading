extends CenterContainer

func _on_start_game_link_pressed():
	get_tree().change_scene_to_file('res://scenes/world.tscn')


func _on_credits_link_pressed():
	get_tree().change_scene_to_file('res://scenes/gui/credits/credits.tscn')


func _on_exit_link_pressed():
		get_tree().quit();
