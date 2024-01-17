# Give the component a class name so it can be instanced as a custom node
class_name ActorStatsComponent
extends Node

@export var stats: ActorStats

var speed: int = 10

# Create the health variable and connect a setter
var hp: int = 15:
	set(value):
		hp = value
		
		# Signal out that the hp has changed
		hp_changed.emit()
		
		# Signal out when hp is at 0
		if hp == 0: no_hp.emit()

# Create our signals for hp
signal hp_changed() # Emit when the hp value has changed
signal no_hp() # Emit when there is no health left

func _ready():
	# copy default values from tres file
	hp = stats.hp
	speed = stats.speed
