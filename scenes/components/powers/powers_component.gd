class_name PowersComponent
extends Node2D

@export var player: Player
var active_powers: Array[PackedScene]
@export var starting_power: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	var instance = starting_power.instantiate()
	add_child(instance)
	active_powers.append(starting_power)
	instance.player = player
	
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#for power in active_powers:
		#power.process_frame(delta)
