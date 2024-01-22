class_name State
extends Node

#@export var animation_name: String

# Hold a reference to the parent so that it can be controlled by the state
var parent: Node
func init(parent: Node):
	parent = parent
	
func enter() -> void:
	#parent.animations.play(animation_name)
	pass

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
