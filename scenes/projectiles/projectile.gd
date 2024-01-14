class_name Projectile
extends Node2D
@export var speed = 50.0 
var direction = Vector2.ZERO

func _physics_process(delta):
	movement(delta)
	
func movement(delta):
	translate(direction * speed * delta)

# Function to set variables
func spawn(variables: Dictionary) -> void:
	for key in variables.keys():
		set(key, variables[key])


func _on_hit_box_hit():
	queue_free()


func _on_self_removal_timer_timeout():
	queue_free()
