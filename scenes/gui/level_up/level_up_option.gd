extends ColorRect
class_name LevelUpOption

@onready var title = $Title
@onready var description = $Description

var item = null
var mouse_over = false
signal selected_upgrade(upgrade)
#XXX: doesn't work for touch screen. I think because mouse_entered never gets triggered. 	
func _ready():
	connect("selected_upgrade", Callable(Global.player.level_up_state, "upgrade_character"))

func _gui_input(event: InputEvent) -> void:
	if event.is_pressed() and event.is_action("ui_accept"):
		emit_signal("selected_upgrade", item)
		
func _input(event: InputEvent) -> void:
	if event.is_action("click"):
		if mouse_over:
			emit_signal("selected_upgrade", item)

func _on_mouse_entered():
	mouse_over = true
	
func _on_mouse_exited():
	mouse_over = false

func _draw() -> void:
	if has_focus():
		self_modulate.a = 1.0
	else:
		self_modulate.a = 0.4
