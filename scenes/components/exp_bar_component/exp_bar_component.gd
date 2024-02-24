class_name ExpBarComponent
extends Node

@onready var fps_low_on_mobile_label: Label = $FPSLowOnMobileLabel
@onready var collect_the_ashes_dialog: Label = $CollectTheAshesDialog

@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar
var playerStatsComponent: PlayerStatsComponent
@onready var fps_meter: Label = $FPSMeter
@export var fps_meter_enabled := false
# Called when the node enters the scene tree for the first time.
func _ready():
	fps_low_on_mobile_label.visible = false
	collect_the_ashes_dialog.visible = true
	
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
	disable_collect_ashes_soon()
	get_tree().create_timer(2)
	
func set_texture_progress():
	texture_progress_bar.value = playerStatsComponent.exp

var has_flashed_message_once = false
func _process(delta):
	if not has_flashed_message_once and not OS.has_feature("pc"):
		if Engine.get_frames_per_second() < 12:
			fps_low_on_mobile_label.visible = true
			disable_that_thang()
		else:
			fps_low_on_mobile_label.visible = false
	if (fps_meter_enabled):
		fps_meter.set_text(str( Engine.get_frames_per_second()))
func disable_that_thang():
	has_flashed_message_once = true
	await get_tree().create_timer(8.0).timeout
	fps_low_on_mobile_label.visible = false

func disable_collect_ashes_soon():
	await get_tree().create_timer(2.0).timeout
	collect_the_ashes_dialog.visible = false

