class_name StrobeComponent
extends Node

var flashInterval : float = 0.1  # Adjust the interval as needed
var flashingTimer : float

@export var sprite: CanvasItem
func _ready():
	flashingTimer = flashInterval
	set_process(false)

func _process(delta):
	flashingTimer -= delta

	if flashingTimer <= 0:
		sprite.visible = !sprite.visible
		flashingTimer = flashInterval

func stop():
	set_process(false)
	sprite.visible = true

func start():
	set_process(true)
	sprite.visible = true
