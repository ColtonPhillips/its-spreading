extends State

@export var idle_state: State
@export var flinch_state: State

var player: Player = null

func init(parent):
	player = parent

func enter():
	player.animated_sprite_2d.play("walk")

func exit():
	player.move_component.velocity = Vector2.ZERO

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta) -> State:
	return null

func process_physics(delta) -> State:
	player.move_component.velocity = player.input_component.direction * player.stats_component.speed	
	if player.velocity.x > 0:
		player.animated_sprite_2d.flip_h = false
	if player.velocity.x < 0:
		player.animated_sprite_2d.flip_h = true
	if player.input_component.direction == Vector2.ZERO:
		return idle_state
		
	return null

func process_hurtbox_component_hurt(hitbox:HitboxComponent):
	flinch_state.collision_hitbox = hitbox
	return flinch_state
