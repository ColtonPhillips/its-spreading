extends Node2D
class_name GUIGameplay
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.gui_gameplay = self
	
@onready var level_up_panel = $LevelUpPanel
