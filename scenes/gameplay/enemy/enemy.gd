class_name Enemy
extends CharacterBody2D

@export var dropped_loot: Resource

#optimize?
@onready var player = Global.player
@onready var scenegraph = Global.player.get_parent()
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var move_component = $MoveComponent
@onready var scale_component = $ScaleComponent
@onready var stats_component = $StatsComponent
@onready var hurt_sfx = $HurtSfx
@onready var kill_sfx = $KillSfx

func _ready():
	kill_sfx.finished.connect(queue_free)

func _physics_process(delta):
	movement(delta)
	animation(delta)
	
func movement(delta):
	var direction = global_position.direction_to(player.global_position)
	move_component.velocity = direction * stats_component.speed

func animation(delta):
	if velocity.x > 0:
		animated_sprite_2d.flip_h = false
	if velocity.x < 0:
		animated_sprite_2d.flip_h = true

@onready var collision_shape_2d = $CollisionShape2D

func _on_hurt_box_hurt(damage):
	stats_component.hp -= damage
	scale_component.tween_scale()
	hurt_sfx.play_with_variance()
	if stats_component.hp <= 0:
		modulate.a = 0.2
		spawn_exp()
		scale_component.tween_scale()
		kill_sfx.play_with_variance()
		
		collision_shape_2d.call_deferred("set", "disabled", false)

func spawn_exp():
	var enemy_spawn = dropped_loot.instantiate()
	enemy_spawn.global_position = self.global_position
	scenegraph.call_deferred("add_child", enemy_spawn)
