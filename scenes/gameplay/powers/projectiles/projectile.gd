class_name Projectile
extends Node2D
@export var speed = 65.0 
var direction = Vector2.ZERO
@onready var move_component = $MoveComponent
@onready var scale_component:ScaleComponent = $ScaleComponent
@export var start_chasing = false
@onready var enemy_chase_range = $EnemyChaseRange

func _ready():
	scale_component.tween_scale()

func _process(delta):
	movement(delta)

func find_closest_area(objects):
	var min_distance = 9999999999
	var closest_body = null

	# Iterate through the list of colliding objects
	for body in objects:
		# Calculate the distance between the projectile and the colliding object
		var distance = position.distance_to(body.position)

		# Check if this object is closer than the current closest one
		if distance < min_distance:
			min_distance = distance
			closest_body = body

	return closest_body		

var enemy_found = false
var found_enemy: CharacterBody2D = null
func movement(delta):
	
	if direction.length_squared() > 0:
		var rotation_radians = atan2(direction.y, direction.x)
		# Assuming the node is a 2D node (Node2D)
		self.rotation = rotation_radians
		
	if the_chase_may_proceed and enemy_found and is_instance_valid(found_enemy) and found_enemy.__state_alive__:
		var direction2 = global_position.direction_to(found_enemy.global_position)
		direction = ( 17 * direction + direction2 ) / 18
		
	move_component.velocity = direction * speed
	

# Function to set variables
func spawn(variables: Dictionary) -> void:
	for key in variables.keys():
		set(key, variables[key])

func _on_self_removal_timer_timeout():
	queue_free()


func _on_enemy_chase_range_body_entered(body):
	
	var overlapping_areas = enemy_chase_range.get_overlapping_bodies()
	if overlapping_areas == []: return
	
	var found_closest_area = find_closest_area(overlapping_areas)
	if (not is_instance_valid(found_closest_area)): return
	
	if (is_instance_valid(found_closest_area)):
		enemy_found = true
		found_enemy = found_closest_area

var the_chase_may_proceed = false

func _on_enable_chase_timer_timeout():
	the_chase_may_proceed = true


func _on_hitbox_component_hit_hurtbox(hurtbox):
	queue_free()
