class_name StopWatchComponent
extends CanvasLayer

@onready var level_label = $levelLabel

# Called when the node enters the scene tree for the first time.
var level: int = 1	
var playerStatsComponent: PlayerStatsComponent

func _ready():
		playerStatsComponent = Global.player.stats_component
		
		playerStatsComponent.level_up.connect( func():
			set_level_label()
		)
		set_level_label()
		
func get_level_label_as_string(level):
		return String("LVL:%02d" % [level ])

func set_level_label():
	level_label.text = get_level_label_as_string(playerStatsComponent.level)
