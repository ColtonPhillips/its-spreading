extends Node2D

@export var spawns: Array[SpawnInfo] = []
@onready var player := Global.player

@onready var vp_rect := get_viewport_rect() 
@onready var vp_rect_size := vp_rect.size
@onready var ray := RayCast2D.new()

func _ready():
	add_child(ray)

# pre: 9.8 ms  , enemy count 162 ish
# now: 5.8 ish, enemy count 122, 16 random positions
var time := 0
func _on_timer_timeout() -> void:
	time += 1
	#XXX: Iterating over every spawn info is probably meh performance but might be trival.
	for info in spawns:
		if time <= info.time_end and time > info.time_start:
			if info.spawn_delay_counter < info.enemy_spawn_delay:
				info.spawn_delay_counter += 1
			else:
				info.spawn_delay_counter = 0
				var new_enemy := info.enemy
				var counter := 0
				while (counter < info.enemy_num):
					
					var try_to_spawn := 16
					var spawn_position: Vector2
					while try_to_spawn > 0:
						spawn_position = get_random_position()
						
						ray.position = spawn_position
						ray.target_position = ray.position
						ray.target_position.x += 0.1
						ray.force_raycast_update()
						try_to_spawn -= 1
						
						if not ray.is_colliding():
							var enemy_spawn: Enemy = new_enemy.instantiate()
							enemy_spawn.global_position = spawn_position
							add_child(enemy_spawn)
							counter += 1
							
							try_to_spawn = 0 # XXX: Crappy method of breaking outer loop (while try_to_spawn > 0)

enum SPAWN_SIDE {LEFT, RIGHT, UP, DOWN}
var vpr_x_over_2: float
var vpr_y_over_2: float
var spawn_pos1 := Vector2.ZERO
var spawn_pos2 := Vector2.ZERO
func get_random_position():
	var vpr := vp_rect_size * randf_range(1.5, 2.5) # could limit to doing this once per "try"
	vpr_x_over_2 = vpr.x * 0.5
	vpr_y_over_2 = vpr.y * 0.5
	
	var pos_side := randi()%4 #could limit this too maybe decouple size and side from spawn placeemnt
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
			
	var x_spawn := randf_range(spawn_pos1.x, spawn_pos2.x)
	var y_spawn := randf_range(spawn_pos1.y, spawn_pos2.y)
	return Vector2(x_spawn, y_spawn)
	
