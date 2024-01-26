extends Node2D
class_name Melee

var direction = Vector2.RIGHT
var scale_y = 1
@onready var actor_stats_component = $ActorStatsComponent
@onready var flash_component = $FlashComponent
@onready var scale_component = $ScaleComponent
@onready var crit_label: Label = $CritLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	actor_stats_component.damage = Global.player.stats_component.damage
	if Global.player.stats_component.critical_hit > randf():
		actor_stats_component.damage *= 1.5
		flash_component.flash()
		scale_component.tween_scale()
		if crit_label:
			crit_label.visible = true

var crit_label_hack = 0
func _process(delta):
	rotation = direction.angle()
	scale.y = scale_y
	crit_label.scale.x = scale.y
	if (crit_label_hack != 0):
		crit_label.position.x += crit_label_hack
		crit_label_hack = 0


func _on_animated_sprite_2d_animation_finished():
	queue_free()
	
# Function to set variables
func spawn(variables: Dictionary) -> void:
	for key in variables.keys():
		set(key, variables[key])
	if (scale_y < 0):
		crit_label_hack = 12	
