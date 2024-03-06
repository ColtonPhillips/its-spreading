extends Node

@export var random_strength := 8.0
@export var shake_fade := 8.0

var rng := RandomNumberGenerator.new()

var shake_strength := 0.0

func apply_shake():
	shake_strength = random_strength

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shake_fade * delta)
		# XXX: I don't think Camera is really supposed to be a child of player but lets just go with it
		if is_instance_valid(Global.player):
			Global.player.camera.offset = random_offset()

func random_offset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))
