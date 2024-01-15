extends LinkButton

func _on_back_button_pressed():
	get_tree().change_scene_to_file('res://scenes/gui/main_menu/main_menu.tscn')
