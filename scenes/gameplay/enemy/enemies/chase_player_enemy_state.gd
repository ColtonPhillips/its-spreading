extends State

@export var flinch_enemy_state: State
@export var death_enemy_state: State
var enemy: Enemy = null

func init(parent):
	enemy = parent

func enter() -> void:
	enemy.animated_sprite_2d.play("walk")

func exit() -> void:
	pass

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	var direction = enemy.global_position.direction_to(Global.player.global_position)
	enemy.move_component.velocity = direction * enemy.stats_component.speed
	if enemy.velocity.x > 0:
		enemy.animated_sprite_2d.flip_h = false
	if enemy.velocity.x < 0:
		enemy.animated_sprite_2d.flip_h = true
	return null

func process_hurtbox_component_hurt(hitbox:HitboxComponent):
	if (hitbox.collision_info.stats):
		enemy.stats_component.hp -= hitbox.collision_info.stats.damage
	if enemy.stats_component.hp <= 0:
		return death_enemy_state
	else:
		return flinch_enemy_state
	
	return null

