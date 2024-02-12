class_name AugmentMotion
extends Node

@export var disabled = false
# Common functionality for all movement modifiers
func modify_velocity(velocity: Vector2) -> Vector2:
	return Vector2.ZERO
