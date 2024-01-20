class_name AugmentKnockbackMotion
extends AugmentMotion

@export var knockback_velocity: Vector2 = Vector2.ZERO
@export var knockback_force: int = 100
@export var dampen_force: int = 1

func modify_velocity(velocity: Vector2):
	if disabled: return
	knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, dampen_force)
	return velocity + knockback_velocity

func knockback(from: Vector2, to: Vector2):
	knockback_velocity =  from.direction_to(to) * knockback_force


func knockback_angle(angle: Vector2):
	knockback_velocity =  angle * knockback_force
