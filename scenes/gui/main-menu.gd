extends Node

func _ready():
	get_tree().paused = true;
	self.visible = true;

func _input(event):
	if Input.is_action_just_pressed("pause"):
		print(get_tree().paused);
		if (get_tree().paused):
			get_tree().paused = false;
			self.visible = false;
		else:
			get_tree().paused = true;
			self.visible = true;
				
