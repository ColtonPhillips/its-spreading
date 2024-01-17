class_name HealthBarComponent
extends Node2D

@onready var texture_progress_bar = $TextureProgressBar
@export var actorStatsComponent: ActorStatsComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	texture_progress_bar.value = actorStatsComponent.hp
	texture_progress_bar.max_value = actorStatsComponent.hp	
	texture_progress_bar.min_value = 0
	actorStatsComponent.hp_changed.connect( func():
		set_texture_progress()
	)
	set_texture_progress()
	
func set_texture_progress():
	texture_progress_bar.value = actorStatsComponent.hp
	texture_progress_bar.visible = not texture_progress_bar.value == texture_progress_bar.max_value;
	

func is_full_hp():
	if (actorStatsComponent.hp == actorStatsComponent.max_hp):
		return true
	return false
		
