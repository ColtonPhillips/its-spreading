class_name StoryMenu
extends Node2D
@onready var node_2d: Node2D = $Node2D

@export var end_pos: int
@export var scroll_speed: float
func _ready():
	node_2d.position.snapped(Vector2.ONE)
	pass

func _physics_process(delta):
	if (node_2d.position.y > end_pos):
		node_2d.position.y -= scroll_speed

func _on_link_button_pressed():
	get_tree().change_scene_to_file('res://scenes/gui/main_menu/main_menu.tscn')
	pass # Replace with function body.
