extends State

@export var walk_state: State
@export var death_state: State

var player: Player = null

func init(parent):
	player = parent

#XXX should be timer based but too tired to think about that now.
var chince = 0
func enter():
	if (collision_hitbox.collision_info.stats):
		player.stats_component.hp -= collision_hitbox.collision_info.stats.damage
	player.augment_knockback_motion.knockback_angle(collision_hitbox.collision_info.angle)
	player.hurtbox_component.process_mode = Node.PROCESS_MODE_DISABLED
	
	player.animated_sprite_2d.play("flinch")
	chince = 20
	player.move_component.velocity = Vector2.ZERO
	
	if not player.dead:
		player.strobe_component.start()
		
		
		Global.delay_create(self, 2.5, func():
			player.strobe_component.stop()
			player.hurtbox_component.process_mode = Node.PROCESS_MODE_INHERIT
		)

func exit():
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta) -> State:
	return null

func process_physics(delta) -> State:
	player.velocity = Vector2.ZERO
	chince -= 1
	if chince == 0:
		if player.dead:
			return death_state
		return walk_state
	return null
