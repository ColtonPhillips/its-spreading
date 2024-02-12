class_name MovePositionComponent
extends Node

@export var actor: Node2D
@export var velocity: Vector2

func _process(delta: float):
	movement(delta)
	
func movement(delta: float):
	actor.translate(velocity * delta)
