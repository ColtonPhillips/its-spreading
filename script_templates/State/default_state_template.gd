extends State

#@export var walk_state: State

var player: Player = null

func init(parent):
	player = parent

func enter() -> void:
	#player.animated_sprite_2d.play("idle")
	pass

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	#if player.input_component.direction != Vector2.ZERO:
	#	return walk_state
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null

func process_hurtbox_component_hurt(hitbox:HitboxComponent):
	pass
