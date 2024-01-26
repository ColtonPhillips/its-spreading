extends Node

var player : Player = null
var gui_gameplay : GUIGameplay = null

# Don't use this in the main menu! 
var ToggledOn = false
func Toggle_Fullscreen():
	ToggledOn = not ToggledOn
	if ToggledOn:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func Toggle_Fullscreen_On():
	ToggledOn = true
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func Toggle_Fullscreen_Off():
	ToggledOn = false
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
func delay_create(parent: Node, delay_seconds: float, callback_function):
	var timer = Timer.new()
	parent.add_child(timer)
	timer.connect("timeout", callback_function)
	timer.connect("timeout", func():
		timer.queue_free()
	)
	timer.wait_time = delay_seconds
	timer.start()

func delay_create_loop(parent: Node, delay_seconds: float, callback_function) -> Timer:
	var timer = Timer.new()
	parent.add_child(timer)
	timer.connect("timeout", callback_function)
	timer.wait_time = delay_seconds
	timer.autostart = true
	timer.start()
	return timer
