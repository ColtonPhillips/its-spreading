class_name Enemy
extends CharacterBody2D

@export var move_speed = 20.0
@export var hp = 80

#optimize?
@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite_2d = $Sprite2D

func _physics_process(delta):
	movement(delta)
	animation(delta)
	
func movement(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * move_speed
	move_and_slide()

func animation(delta):
	if velocity.x > 0:
		sprite_2d.flip_h = true
	if velocity.x < 0:
		sprite_2d.flip_h = false


func _on_hurt_box_hurt(damage):
	hp -= damage
	print(hp)
	if hp <= 0:
		queue_free()
