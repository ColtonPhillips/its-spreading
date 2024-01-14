extends Area2D

@export var damage = 1

@onready var collision_shape_2d = $CollisionShape2D
@onready var disable_timer = $DisableTimer

func tempDisable():
	collision_shape_2d.call_deferred("set", "disabled", true)
	disable_timer.start()
	


func _on_disable_timer_timeout():
	collision_shape_2d.call_deferred("set", "disabled", false)
