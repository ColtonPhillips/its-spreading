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

@export var move_speed = 40.0
@export var hp = 80
@export var projectiles_off = false

func _ready():
	Global.player = self
	fire_rate_timer.timeout.connect(fire_weapon)

func _physics_process(delta):
	movement(delta)
	animation(delta)
		
func movement(delta):
	var x_mov = Input.get_axis("move_left", "move_right")
	var y_mov = Input.get_axis("move_up", "move_down")
	var mov = Vector2(x_mov, y_mov)
	velocity = mov.normalized() * move_speed
	move_and_slide()

func animation(delta):
	if velocity.x > 0:
		animated_sprite_2d.flip_h = false
	if velocity.x < 0:
		animated_sprite_2d.flip_h = true
	if velocity == Vector2.ZERO:
		animated_sprite_2d.play("idle")
	else:
		animated_sprite_2d.play("walk")
		
func _on_hurt_box_hurt(damage):
	hp -= damage
	print(hp)
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
			
		
