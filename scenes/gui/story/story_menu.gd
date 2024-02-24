class_name StoryMenu
extends Node2D
@onready var label:Label = $Label
@export var end_pos: int
@export var scroll_speed: float
func _ready():
	label.position.snapped(Vector2.ONE)
	pass

func _physics_process(delta):
	if (label.position.y > end_pos):
		label.position.y -= scroll_speed


func _on_link_button_pressed():
	get_tree().change_scene_to_file('res://scenes/gui/main_menu/main_menu.tscn')
	pass # Replace with function body.
