extends Node2D
class_name Melee

var direction = Vector2.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(direction)


func _on_animated_sprite_2d_animation_finished():
	queue_free()
	
# Function to set variables
func spawn(variables: Dictionary) -> void:
	for key in variables.keys():
		set(key, variables[key])
