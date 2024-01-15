class_name Pickup
extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@export var move_speed = 100.0
@export var chasing_player = false
@onready var move_component = $MoveComponent
	
func _process(delta):
	if chasing_player:
		var direction = global_position.direction_to(player.global_position)
		move_component.velocity = direction * move_speed
		
		if global_position.distance_to(player.global_position) < 2.0:
			queue_free()

func chase_player():
	print("the chase is on")
	chasing_player = true
