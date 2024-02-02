extends State

@export var walk_state: State

var player: Player = null

func init(parent):
	player = parent

var level_up_prizes = [
	{
		"type": "speed",
		"title": "More Speed",
	 	"description": "Increase your speed!"
	},{
		"type": "range",
		"title": "More Pickup Range",
	 	"description": "Increase your pickup range!"
	},{
		"type": "critical_hit",
		"title": "Critical Hit % Up",
	 	"description": "Get more critical hits"
	},{
		"type": "heal",
		"title": "HP Up",
	 	"description": "Heal some of your HP"
	},{
		"type": "damage",
		"title": "More Damage",
		"description": "Increase your weapon damage!"
	},
]

var level_up_powers = [
	{
		"type": "projectile",
		"title": "Unlock Projectile",
	 	"description": "Get a new weapon!!"
	}
]
var is_level_up_complete = false
var hasProjectile = false
func enter():
	player.animated_sprite_2d.play("level_up")
	player.stats_component.hp += 10
	Global.gui_gameplay.level_up_panel.visible = true
	level_up_prizes.shuffle()
	var next_prizes = level_up_prizes.slice(0,3)
	if not hasProjectile and 0.5 < randf():
		next_prizes[0] = level_up_powers[0]
	Global.gui_gameplay.level_up_panel.set_options(next_prizes)
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
	player.stats_component.upgrade_player(upgrade, player)
	if upgrade.type == "projectile":
		hasProjectile = true
	Global.delay_create(self, 0.4, func():
		get_tree().paused = false
		is_level_up_complete = true
	)
