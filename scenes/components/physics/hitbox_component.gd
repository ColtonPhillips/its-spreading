# Give the component a class name so it can be instanced as a custom node
class_name HitboxComponent
extends Area2D

# Create a signal for when the hitbox hits a hurtbox
signal hit_hurtbox(hurtbox: HurtboxComponent)

var collision_info: CollisionInfo = CollisionInfo.new()

func _ready():
	# Connect on area entered to our hurtbox entered function
	area_entered.connect(_on_hurtbox_entered)
	
	var stats:ActorStatsComponent
	for child in owner.get_children():
		if child.is_in_group("ActorStatsComponent"):
			stats = child
			break
	if (stats):
		collision_info.stats = stats

# XXX: this doesn't work if a user is idly over an enemy that isn't moving. very minor bug for this game so far
func _on_hurtbox_entered(hurtbox):
	# Make sure the area we are overlapping is a hurtbox
	if not hurtbox is HurtboxComponent: return
	# Make sure the hurtbox isn't invincible
	if hurtbox.is_invincible: return
	
	collision_info.angle = calculate_angle(hurtbox)
	# Signal out that we hit a hurtbox (this is useful for destroying projectiles when they hit something)
	hit_hurtbox.emit(hurtbox)
	# Have the hurtbox signal out that it was hit
	hurtbox.hurt.emit(self)

func calculate_angle(hurtbox):
	var angle = Vector2.ZERO
	var myshape = get_child(0)
	#angle = area.global_position.direction_to(global_position)
	var me: Vector2 = get_child(0).global_position
	var them: Vector2 = hurtbox.get_child(0).global_position
	angle =  me.direction_to(them)
	return angle
	
