extends Node2D
class_name Melee

var direction = Vector2.RIGHT
var scale_y = 1
@onready var actor_stats_component = $ActorStatsComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	actor_stats_component.damage = Global.player.stats_component.damage

func _process(delta):
	rotation = direction.angle()
	scale.y = scale_y

func _on_animated_sprite_2d_animation_finished():
	queue_free()
	
# Function to set variables
func spawn(variables: Dictionary) -> void:
	for key in variables.keys():
		set(key, variables[key])
