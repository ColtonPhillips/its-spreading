class_name State
extends Node

var parent: Node
var collision_hitbox: HitboxComponent

func init(parent: Node):
	parent = parent
	
func enter() -> void:
	pass

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null

func process_hurtbox_component_hurt(hitbox:HitboxComponent) -> State:
	return null
