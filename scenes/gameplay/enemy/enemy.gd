class_name Enemy
extends CharacterBody2D

@export var dropped_loot: Resource

@onready var player = Global.player
@onready var scenegraph = Global.player.get_parent()

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var flash_component = $FlashComponent
@onready var shadow = $AnimatedSprite2D/Shadow
@onready var additive_blend_light = $AnimatedSprite2D/AdditiveBlendLight

@onready var move_component = $MoveComponent
@onready var augment_knockback_motion = $MoveComponent/AugmentKnockbackMotion
@onready var health_bar_component = $HealthBarComponent

@onready var scale_component = $ScaleComponent
@onready var stats_component = $StatsComponent
@onready var hurt_sfx = $HurtSfx
@onready var kill_sfx = $KillSfx
@onready var strobe_component = $StrobeComponent
@onready var hitbox_component = $HitboxComponent
@onready var hurtbox_component = $HurtboxComponent
@onready var center = $Center
@onready var state_machine = $StateMachine
@onready var collision_shape_2d = $CollisionShape2D

func _ready():
	# XXX Super mid, change when death state
	kill_sfx.finished.connect(queue_free)
	state_machine.init(self)

var alpha_offset = 0.0
var goal_offset = 0.1
func _process(delta: float) -> void:
	state_machine.process_frame(delta)
	var x = Time.get_ticks_msec()
	if x % 180 == 0:
		goal_offset = randf_range(0.0, 0.06)
	alpha_offset = move_toward(alpha_offset, goal_offset, 0.0002)
	additive_blend_light.modulate = Color(1.0, 1.0, 1.0, 0.15 - alpha_offset)
	
func _physics_process(delta):
	state_machine.process_physics(delta)	
	move_component.process_physics(delta)	

func spawn_exp():
	# This is a pretty mid af implementation lol
	var loot = dropped_loot.instantiate()
	loot.global_position = self.global_position
	scenegraph.call_deferred("add_child", loot)

# TODO REPLACE
func _on_hurtbox_component_hurt(hitbox):
	state_machine.process_hurtbox_component_hurt(hitbox)
