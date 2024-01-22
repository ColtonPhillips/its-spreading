extends State

@export var idle_state: State

var player: Player = null

func init(parent):
	player = parent
var chince = 0
func enter():
	chince = 100
	player.animated_sprite_2d.play("level_up")
	player.stats_component.hp += 10
	get_tree().paused = true
	pass

func exit():
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta) -> State:
	return null

func process_physics(delta) -> State:
	player.move_component.velocity = Vector2.ZERO
	chince -= 1
	if chince == 0:
		get_tree().paused = false
		return idle_state
	return null


func process_hurtbox_component_hurt(hitbox:HitboxComponent):
	pass
