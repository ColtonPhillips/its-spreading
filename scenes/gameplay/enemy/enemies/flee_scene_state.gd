extends State

#@export var walk_state: State

var enemy: Enemy = null

func init(parent):
	enemy = parent

var direction
func enter():
	enemy.animated_sprite_2d.play("walk")
	enemy.collision_shape_2d.disabled = true
	direction = Global.player.global_position.direction_to(enemy.global_position)

func exit():
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta) -> State:
	if not enemy.is_on_screen:
		enemy.destroy()
	return null

func process_physics(delta) -> State:
	enemy.move_component.velocity = direction * enemy.stats_component.speed * 2.5
	if enemy.velocity.x > 0:
		enemy.animated_sprite_2d.flip_h = false
	if enemy.velocity.x < 0:
		enemy.animated_sprite_2d.flip_h = true
	return null

func process_hurtbox_component_hurt(hitbox:HitboxComponent):
	return null

