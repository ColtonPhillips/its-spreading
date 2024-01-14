extends Area2D

@export_enum("Cooldown", "HitOnce", "DisableHit") var HurtBoxType = 0

@onready var collision_shape_2d = $CollisionShape2D
@onready var disable_timer = $DisableTimer

signal hurt(damage)

func _on_disable_timer_timeout():
	collision_shape_2d.call_deferred("set", "disabled", false)

func _on_area_entered(area):
	if area.is_in_group("attack"):
		if area.get("damage") != null:
			match HurtBoxType:
				0: #Cooldown
					collision_shape_2d.call_deferred("set", "disabled", true)
					disable_timer.start()
				1: #Hit Once
					pass
				2: #DisableHitbox
					if area.has_method("tempDisabled"):
						area.tempDisable()
			var damage = area.damage
			emit_signal("hurt", damage)
