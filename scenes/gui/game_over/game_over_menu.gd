extends Control

@export var world_scene: String
@export var main_menu_scene: String

func _on_try_again_button_pressed() -> void:
	get_tree().change_scene_to_file(world_scene)

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file(main_menu_scene)
