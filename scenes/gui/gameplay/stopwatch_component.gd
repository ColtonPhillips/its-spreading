class_name LevelLabelComponent
extends CanvasLayer

@onready var stopwatch_label = $StopwatchLabel

# Called when the node enters the scene tree for the first time.
var time: float = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	stopwatch_label.text = get_time_as_string(time)
	
func get_time():
	return time

func get_time_as_string(time):
 # Format minutes and seconds
	var minutes = int(time / 60)
	var seconds = int(int(time) % 60)

	# Display formatted time
	return String("%02d:%02d" % [minutes, seconds])
