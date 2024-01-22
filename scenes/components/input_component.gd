class_name InputComponent
extends Node

var direction= Vector2.ZERO

func process_input(event: InputEvent) -> void:
	var x_mov = Input.get_axis("move_left", "move_right")
	var y_mov = Input.get_axis("move_up", "move_down")
	direction = Vector2(x_mov, y_mov).normalized()
