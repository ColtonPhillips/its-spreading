class_name ExpBarComponent
extends Node

@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar
var playerStatsComponent: PlayerStatsComponent
@onready var fps_meter: Label = $FPSMeter
@export var fps_meter_enabled := false
# Called when the node enters the scene tree for the first time.
func _ready():
	playerStatsComponent = Global.player.stats_component
	texture_progress_bar.value = playerStatsComponent.exp
	texture_progress_bar.max_value = playerStatsComponent.max_exp	
	texture_progress_bar.min_value = 0
	playerStatsComponent.exp_changed.connect( func():
		set_texture_progress()
	)
	playerStatsComponent.level_up.connect( func():
		texture_progress_bar.max_value = playerStatsComponent.max_exp	
	)
	set_texture_progress()
	
func set_texture_progress():
	texture_progress_bar.value = playerStatsComponent.exp

func _process(delta):
	if (fps_meter_enabled):
		fps_meter.set_text(str( Engine.get_frames_per_second()))


