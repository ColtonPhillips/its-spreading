class_name LevelLabelComponent
extends CanvasLayer
@onready var you_win_label = $YouWinLabel

@onready var stopwatch_label:Label = $StopwatchLabel
@export var game_length_in_minutes = 0.5
# Called when the node enters the scene tree for the first time.
var time: float = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
var never_again = true
func _process(delta):
	time += delta
	stopwatch_label.text = get_time_as_string(time)
	if not you_win_label.visible and never_again and (time / 60 > game_length_in_minutes):
		you_win_label.visible = true
		Global.delay_create(self, 3, func():
			you_win_label.visible = false
			never_again = false
		)
		
	
func get_time():
	return time

func get_time_as_string(time):
 # Format minutes and seconds
	var minutes = int(time / 60)
	var seconds = int(int(time) % 60)

	# Display formatted time
	return String("%02d:%02d" % [minutes, seconds])
