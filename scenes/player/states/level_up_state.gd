extends State

@export var walk_state: State

var player: Player = null

func init(parent):
	player = parent

var level_up_prizes = [
	{"title": "More Speed",
	 "description": "Increase your speed!"},
	{"title": "More Range",
	 "description": "Increase your pickup range!"},
	{"title": "More Damage",
	 "description": "Increase your weapon damage!"},
]
var is_level_up_complete = false
func enter():
	player.animated_sprite_2d.play("level_up")
	player.stats_component.hp += 10
	Global.gui_gameplay.level_up_panel.visible = true
	Global.gui_gameplay.level_up_panel.set_options(level_up_prizes)
	is_level_up_complete = false
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
	if is_level_up_complete:
		is_level_up_complete = false
		return walk_state
	return null


func process_hurtbox_component_hurt(hitbox:HitboxComponent):
	pass

func upgrade_character(upgrade):
	Global.gui_gameplay.level_up_panel.visible = false
	get_tree().paused = false
	is_level_up_complete = true
	print (upgrade)
