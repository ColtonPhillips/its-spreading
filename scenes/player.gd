class_name Player
extends CharacterBody2D

@onready var spawner_component = $SpawnerComponent
@onready var right_slot = $Slots/RightSlot
@onready var down_slot = $Slots/DownSlot
@onready var up_slot = $Slots/UpSlot
@onready var left_slot = $Slots/LeftSlot
@onready var sprite_2d = $Sprite2D
@onready var fire_rate_timer = $FireRateTimer

@export var move_speed = 40.0

func _ready():
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
		sprite_2d.flip_h = true
	if velocity.x < 0:
		sprite_2d.flip_h = false

func fire_weapon():
	spawner_component.spawn(right_slot.global_position, {"direction": Vector2.RIGHT})
	spawner_component.spawn(down_slot.global_position, {"direction": Vector2.DOWN})
	spawner_component.spawn(left_slot.global_position, {"direction": Vector2.LEFT})
	spawner_component.spawn(up_slot.global_position, {"direction": Vector2.UP})
