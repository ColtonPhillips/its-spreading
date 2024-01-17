class_name MoveInputComponent
extends Node

@export var stats_component: ActorStatsComponent
@export var move_component: MoveCharacterBody2DComponent

func _input(event: InputEvent) -> void:
	var x_mov = Input.get_axis("move_left", "move_right")
	var y_mov = Input.get_axis("move_up", "move_down")
	var mov = Vector2(x_mov, y_mov)
	move_component.velocity = mov.normalized() * stats_component.speed
