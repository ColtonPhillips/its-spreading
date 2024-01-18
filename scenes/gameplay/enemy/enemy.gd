class_name Enemy
extends CharacterBody2D

@export var dropped_loot: Resource

#optimize?
@onready var player = Global.player
@onready var scenegraph = Global.player.get_parent()
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var flash_component = $FlashComponent

@onready var move_component = $MoveComponent
@onready var scale_component = $ScaleComponent
@onready var stats_component = $StatsComponent
@onready var hurt_sfx = $HurtSfx
@onready var kill_sfx = $KillSfx
@onready var hurt_box = $HurtBox

func _ready():
	kill_sfx.finished.connect(queue_free)
	
var knockback = Vector2.ZERO

func _physics_process(delta):
	movement(delta)
	_knockback(delta)
	animation(delta)
	
func movement(delta):
	var direction = global_position.direction_to(player.global_position)
	move_component.velocity = direction * stats_component.speed
	
func _knockback(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 4)
	move_component.velocity += knockback

func animation(delta):
	if velocity.x > 0:
		animated_sprite_2d.flip_h = false
	if velocity.x < 0:
		animated_sprite_2d.flip_h = true

@onready var collision_shape_2d = $CollisionShape2D

func _on_hurt_box_hurt(damage, angle):
	stats_component.hp -= damage
	knockback = angle * 100
	scale_component.tween_scale()
	hurt_sfx.play_with_variance()
	flash_component.flash()
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
