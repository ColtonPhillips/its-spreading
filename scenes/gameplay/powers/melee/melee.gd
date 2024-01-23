extends Node2D
class_name Melee

var direction = Vector2.RIGHT
var scale_y = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	rotation = direction.angle()
	scale.y = scale_y

func _on_animated_sprite_2d_animation_finished():
	queue_free()
	
# Function to set variables
func spawn(variables: Dictionary) -> void:
	for key in variables.keys():
		set(key, variables[key])
