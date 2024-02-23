extends State

var player: Player = null

func init(parent: Node):
	player = (parent as Player)

func enter():
	player.animated_sprite_2d.play("death")
	get_tree().paused = true
	Global.delay_create(self, 2.5, func():
		get_tree().paused = false
		get_tree().change_scene_to_file("res://scenes/gui/game_over/game_over_menu.tscn")
	)

func exit():
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta) -> State:
	return null

func process_physics(delta) -> State:
	return null

func process_hurtbox_component_hurt(hitbox:HitboxComponent):
	return null

