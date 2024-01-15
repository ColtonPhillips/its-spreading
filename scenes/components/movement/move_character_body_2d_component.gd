class_name MoveCharacterBody2DComponent
extends Node

@export var actor: Node2D
@export var velocity: Vector2
@export_enum("Slow:30", "Average:60", "Very Fast:200") var character_speed: int

func _physics_process(delta):
	movement(delta)
		
func movement(delta):
	actor.velocity = velocity
	actor.move_and_slide()
