class_name Player
extends CharacterBody2D

@onready var spawner_component = $SpawnerComponent
@onready var right_slot = $Slots/RightSlot
@onready var down_slot = $Slots/DownSlot
@onready var up_slot = $Slots/UpSlot
@onready var left_slot = $Slots/LeftSlot
@onready var fire_rate_timer = $FireRateTimer
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var top_right_slot = $Slots/TopRightSlot
@onready var bottom_left_slot = $Slots/BottomLeftSlot
@onready var top_left_slot = $Slots/TopLeftSlot
@onready var bottom_right_slot = $Slots/BottomRightSlot
@onready var pickup_sfx = $PickupSfx
@onready var move_component = $MoveComponent
@onready var move_input_component = $MoveInputComponent
@onready var stats_component = $PlayerStatsComponent
@onready var augment_knockback_motion = $MoveComponent/AugmentKnockbackMotion
@onready var strobe_component = $StrobeComponent
@onready var hurtbox_component = $HurtboxComponent

@export var projectiles_off = false

var timer = Timer.new()
func delay_create(delay_seconds: float, callback_function):
	timer.connect("timeout", callback_function)
	timer.wait_time = delay_seconds
	timer.start()
	
func _ready():
	Global.player = self
	add_child(timer)
	
	fire_rate_timer.timeout.connect(fire_weapon)

func _input(event: InputEvent) -> void:
	var x = Input.get("toggle_fullscreen")
	if event.is_action_pressed("toggle_fullscreen"):
		Global.Toggle_Fullscreen()
		
func _physics_process(delta):
	animation(delta)

func animation(delta):
	if velocity.x > 0:
		animated_sprite_2d.flip_h = false
	if velocity.x < 0:
		animated_sprite_2d.flip_h = true
	if velocity == Vector2.ZERO:
		animated_sprite_2d.play("idle")
	else:
		animated_sprite_2d.play("walk")
		

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
	
func _on_pickup_range_area_entered(area):
	if area.is_in_group("pickup"):
		if area.get_parent().has_method("chase_player"):
			area.get_parent().chase_player()
			pickup_sfx.play_with_variance()
			
func _on_hurtbox_component_hurt(hitbox: HitboxComponent):
	if (hitbox.collision_info.stats):
		stats_component.hp -= hitbox.collision_info.stats.damage
	augment_knockback_motion.knockback_angle(hitbox.collision_info.angle)
	strobe_component.start()
	hurtbox_component.process_mode = Node.PROCESS_MODE_DISABLED
	delay_create(2.5, func():
		strobe_component.stop()
		hurtbox_component.process_mode = Node.PROCESS_MODE_INHERIT
	)
	

