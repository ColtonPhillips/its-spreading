class_name Enemy
extends CharacterBody2D

@export var move_speed = 20.0
@export var hp = 80
@export var dropped_loot: Resource

#optimize?
@onready var player = get_tree().get_first_node_in_group("player")
@onready var scenegraph = get_tree().get_first_node_in_group("player").get_parent()
@onready var sprite_2d = $Sprite2D
@onready var move_component = $MoveComponent

func _physics_process(delta):
	movement(delta)
	animation(delta)
	
func movement(delta):
	var direction = global_position.direction_to(player.global_position)
	move_component.velocity = direction * move_speed

func animation(delta):
	if velocity.x > 0:
		sprite_2d.flip_h = true
	if velocity.x < 0:
		sprite_2d.flip_h = false


func _on_hurt_box_hurt(damage):
	hp -= damage
	print(hp)
	if hp <= 0:
		spawn_exp()
		queue_free()

func spawn_exp():
	var enemy_spawn = dropped_loot.instantiate()
	enemy_spawn.global_position = self.global_position
	scenegraph.call_deferred("add_child", enemy_spawn)
