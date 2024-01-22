extends State

var player: Player = null

func init(parent):
	player = parent

func enter():
	player.animated_sprite_2d.play("death")
	Global.delay_create(self, 2.5, func():
		get_tree().change_scene_to_file("res://scenes/gui/main_menu/main_menu.tscn")
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
	pass

