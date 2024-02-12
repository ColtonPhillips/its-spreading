class_name Pickup
extends Node2D

@onready var player := Global.player
@export var move_speed := 100.0
@export var chasing_player := false
@onready var move_component: MovePositionComponent = $MoveComponent
@export var pickup_value: int = 5
func _process(delta: float) -> void:
	if chasing_player:
		var direction := global_position.direction_to(player.global_position)
		move_component.velocity = direction * move_speed
		
		if global_position.distance_to(player.global_position) < 2.0:
			Global.player.stats_component.exp += pickup_value
			queue_free()

func chase_player():
	chasing_player = true
