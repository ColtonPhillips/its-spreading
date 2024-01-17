extends Node

var player : Player = null

# Don't use this in the main menu! 
var ToggledOn = false
func Toggle_Fullscreen():
	ToggledOn = not ToggledOn
	if ToggledOn:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
