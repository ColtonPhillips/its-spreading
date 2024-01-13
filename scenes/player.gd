class_name Player
extends CharacterBody2D

@export var move_speed = 40.0


func _physics_process(delta):
	movement(delta)
	
func movement(delta):
	var x_mov = Input.get_axis("move_left", "move_right")
	var y_mov = Input.get_axis("move_up", "move_down")
	var mov = Vector2(x_mov, y_mov)
	velocity = mov.normalized() * move_speed
	move_and_slide()
