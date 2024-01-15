class_name Projectile
extends Node2D
@export var speed = 50.0 
var direction = Vector2.ZERO
@onready var move_component = $MoveComponent

func _process(delta):
	movement(delta)
	
func movement(delta):
	move_component.velocity = direction * speed
	
	if direction.length_squared() > 0:
		var rotation_radians = atan2(direction.y, direction.x)
		# Assuming the node is a 2D node (Node2D)
		self.rotation = rotation_radians

# Function to set variables
func spawn(variables: Dictionary) -> void:
	for key in variables.keys():
		set(key, variables[key])


func _on_hit_box_hit():
	queue_free()


func _on_self_removal_timer_timeout():
	queue_free()
