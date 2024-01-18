class_name HurtBox
extends Area2D

@export_enum("Cooldown", "HitOnce", "DisableHit") var HurtBoxType = 0

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var disable_timer = $DisableTimer

signal hurt(damage, angle)

func _on_disable_timer_timeout():
	collision_shape_2d.call_deferred("set", "disabled", false)

func _on_area_entered(area: Area2D):
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
			var angle = Vector2.ZERO
			#angle = area.global_position.direction_to(global_position)
			var a: Vector2 = global_position + collision_shape_2d.position
			var b: Vector2 = area.global_position + area.collision_shape_2d.position
			angle =  b.direction_to(a)

			emit_signal("hurt", damage, angle)
			if area.has_method("hit_received"):
				area.hit_received()
