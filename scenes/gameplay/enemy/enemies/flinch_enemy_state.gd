extends State

var enemy: Enemy = null
@export var chase_player_enemy_state: State
func init(parent: Node):
	enemy = (parent as Enemy)

func enter():
	# TDODO: Change to Hit State
	#XXX: erf suddenly angle is bad naming!
	enemy.animated_sprite_2d.play("flinch")
	var weighted_angle := Global.player.slots.global_position.direction_to(enemy.center.global_position).angle()
	enemy.augment_knockback_motion.knockback_angle(Vector2.from_angle(weighted_angle))
	
	enemy.scale_component.tween_scale()
	enemy.hurt_sfx.play_with_variance()
	enemy.flash_component.flash()
	Global.delay_create(self, 0.6, func():
		enemy.state_machine.change_state(chase_player_enemy_state)
	)

func exit():
	pass

func process_input(event: InputEvent) -> State:
	#if enemy.input_component.direction != Vector2.ZERO:
	#	return walk_state
	return null

func process_frame(delta) -> State:
	return null

func process_physics(delta) -> State:
	return null

#XXX Cannot die in idle state. 
# This is probably a case for having 2 seperate FSM
func process_hurtbox_component_hurt(hitbox:HitboxComponent):
	pass

