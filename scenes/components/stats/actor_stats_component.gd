# Give the component a class name so it can be instanced as a custom node
class_name ActorStatsComponent
extends Node

@export var stats: ActorStats
var hasOneShotHitbox: bool = false

var speed: int = 10
var damage: int = 5
# Create the health variable and connect a setter
var max_hp: int = 15
var hp_initialized = false
var hp: int = 15:
	set(value):
		if not hp_initialized:
			value = max_hp
			hp_initialized = true
		
		hp = min(value, max_hp)
		# Signal out that the hp has changed
		hp_changed.emit()
		
		# Signal out when hp is at 0
		if hp <= 0: no_hp.emit()

# Create our signals for hp
signal hp_changed() # Emit when the hp value has changed
signal no_hp() # Emit when there is no health left

func _ready():
	# copy default values from tres file
	add_to_group("ActorStatsComponent")
	max_hp = stats.hp
	hp = stats.hp
	speed = stats.speed
	damage = stats.damage
	hasOneShotHitbox = stats.hasOneShotHitbox
	
