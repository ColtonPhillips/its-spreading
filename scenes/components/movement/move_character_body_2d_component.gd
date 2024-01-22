class_name MoveCharacterBody2DComponent
extends Node

@export var actor: Node2D
@export var velocity: Vector2

@export var augment_motions: Array[AugmentMotion] = []

func process_physics(delta):
	movement(delta)
		
func movement(delta):
	actor.velocity = velocity
	for augment in augment_motions:
		actor.velocity = augment.modify_velocity(actor.velocity)
	
	if (actor.velocity.length() < 1):
		return
	actor.move_and_slide()
