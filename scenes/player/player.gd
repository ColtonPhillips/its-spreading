class_name Player
extends CharacterBody2D

@onready var spawner_component = $SpawnerComponent
@onready var right_slot = $Slots/RightSlot
@onready var down_slot = $Slots/DownSlot
@onready var up_slot = $Slots/UpSlot
@onready var left_slot = $Slots/LeftSlot
@onready var fire_rate_timer = $FireRateTimer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var top_right_slot = $Slots/TopRightSlot
@onready var bottom_left_slot = $Slots/BottomLeftSlot
@onready var top_left_slot = $Slots/TopLeftSlot
@onready var bottom_right_slot = $Slots/BottomRightSlot
@onready var pickup_sfx = $PickupSfx
@onready var move_component: MoveCharacterBody2DComponent = $MoveComponent
@onready var input_component: InputComponent = $InputComponent
@onready var stats_component: PlayerStatsComponent = $PlayerStatsComponent
@onready var augment_knockback_motion = $MoveComponent/AugmentKnockbackMotion
@onready var strobe_component = $StrobeComponent
@onready var hurtbox_component = $HurtboxComponent
@onready var state_machine: StateMachine = $StateMachine

@export var projectiles_off = false
	
func _ready():
	Global.player = self
	state_machine.init(self)
	
	var timer = Global.delay_create_loop(self, 3.5, fire_weapon)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)
	
func _input(event: InputEvent) -> void:
	input_component.process_input(event)
	state_machine.process_input(event)
	
	var x = Input.get("toggle_fullscreen")
	if event.is_action_pressed("toggle_fullscreen"):
		Global.Toggle_Fullscreen()
		
func _process(delta: float) -> void:
	state_machine.process_frame(delta)
func _physics_process(delta):
	state_machine.process_physics(delta)	
	move_component.process_physics(delta)

func _on_hurtbox_component_hurt(hitbox: HitboxComponent):
	state_machine.process_hurtbox_component_hurt(hitbox)

@onready var level_up_state = $StateMachine/LevelUpState
func _on_player_stats_component_level_up():
	state_machine.change_state(level_up_state)

#XXX this sucks
var dead = false
func _on_player_stats_component_no_hp():
	dead = true
	
func _on_pickup_range_area_entered(area):
	if area.is_in_group("pickup"):
		if area.get_parent().has_method("chase_player"):
			area.get_parent().chase_player()
			pickup_sfx.play_with_variance()

var flip_flop = true
func fire_weapon():
	if projectiles_off:
		return
	flip_flop = !flip_flop
	if flip_flop == true:
		spawner_component.spawn(right_slot.global_position, {"direction": Vector2.RIGHT}, get_parent())
		spawner_component.spawn(down_slot.global_position, {"direction": Vector2.DOWN}, get_parent())
		spawner_component.spawn(left_slot.global_position, {"direction": Vector2.LEFT}, get_parent())
		spawner_component.spawn(up_slot.global_position, {"direction": Vector2.UP}, get_parent())
	else:
		spawner_component.spawn(top_left_slot.global_position, {"direction": (Vector2.UP + Vector2.LEFT) / 2}, get_parent())
		spawner_component.spawn(top_right_slot.global_position, {"direction": (Vector2.UP + Vector2.RIGHT) / 2}, get_parent())
		spawner_component.spawn(bottom_left_slot.global_position, {"direction": (Vector2.DOWN + Vector2.LEFT) / 2}, get_parent())
		spawner_component.spawn(bottom_right_slot.global_position, {"direction": (Vector2.DOWN + Vector2.RIGHT) / 2}, get_parent())
	
