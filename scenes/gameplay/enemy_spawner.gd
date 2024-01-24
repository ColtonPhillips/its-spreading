extends Node2D

@export var spawns: Array[SpawnInfo] = []
@onready var player = Global.player

func _ready():
	vp_rect = get_viewport_rect()
	vp_rect_size = vp_rect.size

var time = 0
func _on_timer_timeout():
	time += 1
	for i in spawns:
		if time > i.time_start and time <= i.time_end:
			if i.spawn_delay_counter < i.enemy_spawn_delay:
				i.spawn_delay_counter += 1
			else:
				i.spawn_delay_counter = 0
				var new_enemy = i.enemy
				var counter = 0
				while (counter < i.enemy_num):
					var enemy_spawn = new_enemy.instantiate()
					enemy_spawn.global_position = get_random_position()
					add_child(enemy_spawn)
					counter += 1
		
				
var vp_rect: Rect2
var vp_rect_size: Vector2
var vpr_x_over_2: float
var vpr_y_over_2: float
enum SPAWN_SIDE {LEFT, RIGHT, UP, DOWN}
func get_random_position():
	var vpr = vp_rect_size * randf_range(1.4, 1.8)
	vpr_x_over_2 = vpr.x / 2
	vpr_y_over_2 = vpr.y / 2
	# Only load these when needed
	#var top_left = Vector2(player.global_position.x - vpr_x_over_2, player.global_position.y - vpr_y_over_2)
	#var top_right = Vector2(player.global_position.x + vpr_x_over_2, player.global_position.y - vpr_y_over_2)
	#var bottom_left = Vector2(player.global_position.x - vpr_x_over_2, player.global_position.y + vpr_y_over_2)
	#var bottom_right = Vector2(player.global_position.x + vpr_x_over_2, player.global_position.y + vpr_y_over_2)
	var spawn_pos1 = Vector2.ZERO
	var spawn_pos2 = Vector2.ZERO
	
	var pos_side = randi()%4
	match pos_side:
		SPAWN_SIDE.UP:
			spawn_pos1 = Vector2(player.global_position.x - vpr_x_over_2, player.global_position.y - vpr_y_over_2)
			spawn_pos2 = Vector2(player.global_position.x + vpr_x_over_2, player.global_position.y - vpr_y_over_2)
		SPAWN_SIDE.DOWN:
			spawn_pos1 = Vector2(player.global_position.x - vpr_x_over_2, player.global_position.y + vpr_y_over_2)
			spawn_pos2 = Vector2(player.global_position.x + vpr_x_over_2, player.global_position.y + vpr_y_over_2)
		SPAWN_SIDE.LEFT:
			spawn_pos1 = Vector2(player.global_position.x + vpr_x_over_2, player.global_position.y - vpr_y_over_2)
			spawn_pos2 = Vector2(player.global_position.x + vpr_x_over_2, player.global_position.y + vpr_y_over_2)
		SPAWN_SIDE.RIGHT:
			spawn_pos1 = Vector2(player.global_position.x - vpr_x_over_2, player.global_position.y - vpr_y_over_2)
			spawn_pos2 = Vector2(player.global_position.x - vpr_x_over_2, player.global_position.y + vpr_y_over_2)
			
	var x_spawn = randf_range(spawn_pos1.x, spawn_pos2.x)
	var y_spawn = randf_range(spawn_pos1.y, spawn_pos2.y)
	return Vector2(x_spawn, y_spawn)
	
