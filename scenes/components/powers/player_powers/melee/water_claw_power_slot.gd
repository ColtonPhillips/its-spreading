extends PowerSlot
class_name WaterColorPowerSlot
@onready var spawner_component = $SpawnerComponent
@onready var ui_pivot = $UIPivot

# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Global.delay_create_loop(self, 1.8, hit_melee)
	
var flip_flop = true
func hit_melee():
	Global.delay_create(self, 0.8, func():
		ui_pivot.rotate(deg_to_rad(180))
	)
	if flip_flop == true:
		spawner_component.spawn(player.far_right_slot.global_position, {"direction": Vector2.RIGHT}, get_parent())
	else:
		spawner_component.spawn(player.far_left_slot.global_position, {"direction": Vector2.LEFT, "scale_y": -1}, get_parent())		
	flip_flop = !flip_flop
		
