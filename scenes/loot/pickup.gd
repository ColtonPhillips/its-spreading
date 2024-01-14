class_name Pickup
extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@export var move_speed = 100.0
@export var chasing_player = false
	
func _physics_process(delta):
	if chasing_player:
		var direction = global_position.direction_to(player.global_position)
		#position.move_toward(direction * move_speed, delta)
		global_translate(direction * move_speed * delta)
		if global_position.distance_to(player.global_position) < 2.0:
			queue_free()

func chase_player():
	print("the chase is on")
	chasing_player = true
