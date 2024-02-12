# Give the component a class name so it can be instanced as a custom node
class_name FlashComponent
extends Node

# The flash component uses a flash material. I chose to preload this into a constant
# But you could also export a material instead to allow the component to use a variety
# of different materials
const FLASH_MATERIAL:ShaderMaterial = preload("res://scenes/components/effects/flash/white_flash_material.tres")

# Export the sprite this compononet will be flashing
@export var sprite: CanvasItem

# Export a duration for the flash
@export var flash_duration: = 0.2

# We need to store the original sprite's material so we can reset it after the flash
var original_sprite_material: Material

# Create a timer for the flash component to use
var timer: Timer = Timer.new()

func _ready() -> void:
	# We have to add the timer as a child of this component in order to use it
	add_child(timer)
	
	# Store the original sprite material
	original_sprite_material = sprite.material


func _process(delta: float):
		# Check if the timer is active
	if is_instance_valid(timer) and not timer.is_stopped():
		# Get the time remaining on the timer
		var time_left := timer.get_time_left()

		# Get the total duration of the timer
		var total_duration := timer.get_wait_time()

		# Calculate the decimal value between 0 and 1
		var time_remaining_decimal := maxf(0.2,1.0 - time_left / total_duration)
		if sprite.material:
			sprite.material.set_shader_parameter("tween", time_remaining_decimal)
	else:
		pass

# This is the function we can use to activate this component
func flash():
	# Set the sprite's material to the flash material
	sprite.material = FLASH_MATERIAL
	
	# Start the timer (passing in the flash duration)
	timer.start(flash_duration)
	
	# Wait until the timer times out
	await timer.timeout
	
	# Set the sprite's material back to the original material that we stored
	sprite.material = original_sprite_material
