extends CenterContainer

@export var start_game_scene: Resource
@export var credits_scene: Resource

func _on_start_game_link_pressed():
	#get_tree().change_scene_to_file(start_game_scene)
	get_tree().change_scene_to_packed(start_game_scene)

func _on_credits_link_pressed():
	#get_tree().change_scene_to_file(credits_scene)
	get_tree().change_scene_to_packed(credits_scene)

func _on_exit_link_pressed():
	get_tree().quit();
