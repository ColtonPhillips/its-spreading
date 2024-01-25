extends State

var enemy: Enemy = null
func init(parent):
	enemy = parent

func enter():
	# TDODO: Change to Hit State
	#XXX: erf suddenly angle is bad naming!
	enemy.animated_sprite_2d.play("death")
	var weighted_angle = Global.player.slots.global_position.direction_to(enemy.center.global_position).angle()
	enemy.augment_knockback_motion.knockback_angle(Vector2.from_angle(weighted_angle))
	enemy.move_component.velocity = Vector2.ZERO
	enemy.scale_component.tween_scale()
	enemy.shadow.visible = false
	enemy.additive_blend_light.visible = false
	enemy.health_bar_component.visible = false
	enemy.hitbox_component.process_mode = Node.PROCESS_MODE_DISABLED
	enemy.hurtbox_component.process_mode = Node.PROCESS_MODE_DISABLED
	#enemy.strobe_component.start()
	enemy.collision_shape_2d.call_deferred("set", "disabled", false)
#
	## XXX: this eventually kills the player
	enemy.kill_sfx.play_with_variance()
	Global.delay_create(self, 0.6, enemy.spawn_exp)	
	
func exit():
	pass

func process_frame(delta) -> State:
	return null

func process_physics(delta) -> State:
	return null

# This is probably a case for having 2 seperate FSM
func process_hurtbox_component_hurt(hitbox:HitboxComponent):
	return null

