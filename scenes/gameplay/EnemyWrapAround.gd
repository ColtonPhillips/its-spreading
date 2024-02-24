extends Node2D

func _on_timer_timeout() -> void:
	var enemies := Global.enemies
	enemies.shuffle()
	for enemy in enemies:
		# XXX: I think the is instance check is important because the enemy erasing, and timer timing is fucky wucky 
		if is_instance_valid(enemy) and not enemy.is_on_screen and enemy.has_been_on_screen:
			enemy.position += 2 * (Global.player.global_position - enemy.global_position)
			return
