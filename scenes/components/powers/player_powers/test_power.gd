class_name TestPower
extends Power

@export var projectiles_off = false
@onready var spawner_component = $SpawnerComponent
@onready var ui_pivot = $UIPivot

# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Global.delay_create_loop(self, 3.5, fire_weapon)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
var flip_flop = true
func fire_weapon():
	if projectiles_off:
		return
	Global.delay_create(self, 0.5, func():
		ui_pivot.rotate(deg_to_rad(45))
	)
	flip_flop = !flip_flop
	if flip_flop == true:
		spawner_component.spawn(player.right_slot.global_position, {"direction": Vector2.RIGHT}, get_parent())
		spawner_component.spawn(player.down_slot.global_position, {"direction": Vector2.DOWN}, get_parent())
		spawner_component.spawn(player.left_slot.global_position, {"direction": Vector2.LEFT}, get_parent())
		spawner_component.spawn(player.up_slot.global_position, {"direction": Vector2.UP}, get_parent())
	else:
		spawner_component.spawn(player.top_left_slot.global_position, {"direction": (Vector2.UP + Vector2.LEFT) / 2}, get_parent())
		spawner_component.spawn(player.top_right_slot.global_position, {"direction": (Vector2.UP + Vector2.RIGHT) / 2}, get_parent())
		spawner_component.spawn(player.bottom_left_slot.global_position, {"direction": (Vector2.DOWN + Vector2.LEFT) / 2}, get_parent())
		spawner_component.spawn(player.bottom_right_slot.global_position, {"direction": (Vector2.DOWN + Vector2.RIGHT) / 2}, get_parent())
		
