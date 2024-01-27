extends Node2D
@onready var label:Label = $Label

func _ready():
	label.position.snapped(Vector2.ONE)
	pass

func _physics_process(delta):
	if (label.position.y > -325):
		label.position.y -= 0.2


func _on_link_button_pressed():
	get_tree().change_scene_to_file('res://scenes/gui/main_menu/main_menu.tscn')
	pass # Replace with function body.
