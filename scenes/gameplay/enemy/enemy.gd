class_name Enemy
extends CharacterBody2D

@export var dropped_loot: PackedScene

@onready var player := Global.player
@onready var scenegraph := Global.player.get_parent()

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D as AnimatedSprite2D
@onready var flash_component: FlashComponent = $FlashComponent as FlashComponent
@onready var shadow: Sprite2D = $AnimatedSprite2D/Shadow as Sprite2D
@onready var additive_blend_light: Sprite2D = $AnimatedSprite2D/AdditiveBlendLight as Sprite2D

@onready var move_component: MoveCharacterBody2DComponent = $MoveComponent as MoveCharacterBody2DComponent
@onready var augment_knockback_motion: AugmentKnockbackMotion = $MoveComponent/AugmentKnockbackMotion as AugmentKnockbackMotion
@onready var health_bar_component: HealthBarComponent = $HealthBarComponent as HealthBarComponent

@onready var scale_component: ScaleComponent = $ScaleComponent as ScaleComponent
@onready var stats_component: ActorStatsComponent = $StatsComponent as ActorStatsComponent
@onready var hurt_sfx: VariablePitchAudioStreamPlayer = $HurtSfx as VariablePitchAudioStreamPlayer
@onready var kill_sfx: VariablePitchAudioStreamPlayer = $KillSfx as VariablePitchAudioStreamPlayer
@onready var strobe_component: StrobeComponent = $StrobeComponent as StrobeComponent
@onready var hitbox_component: HitboxComponent = $HitboxComponent as HitboxComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent as HurtboxComponent
@onready var center: Node2D = $Center as Node2D
@onready var state_machine: StateMachine = $StateMachine as StateMachine
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D as CollisionShape2D

@onready var is_ready_to_flee = false
@onready var is_on_screen = false

static var enemy_count := 0

func _ready():
	# XXX Super mid, change when death state
	kill_sfx.finished.connect(destroy)
	state_machine.init(self)
	
	Global.delay_create(self, 90, func():
		is_ready_to_flee = true
	)
	enemy_count += 1 

#var alpha_offset := 0.0
#var goal_offset := 0.1
func _process(delta: float) -> void:
	state_machine.process_frame(delta)
	# Disable this feature until I know how to do it with performance
	#var x := Time.get_ticks_msec()
	#if x % 180 == 0:
		#goal_offset = randf_range(0.0, 0.06)
	#alpha_offset = move_toward(alpha_offset, goal_offset, 0.0002)
	#additive_blend_light.modulate = Color(1.0, 1.0, 1.0, 0.15 - alpha_offset)

var isAlive = true
func is_alive():
	return isAlive
	
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)	
	move_component.process_physics(delta)	

func spawn_exp():
	# This is a pretty mid af implementation lol
	var loot := dropped_loot.instantiate()
	loot.global_position = self.global_position
	scenegraph.call_deferred("add_child", loot)

# TODO REPLACE -- wait why?
func _on_hurtbox_component_hurt(hitbox: HitboxComponent):
	state_machine.process_hurtbox_component_hurt(hitbox)
	#FreezeFrameEffectComponent.freeze_frame_soft()


func _on_visible_on_screen_notifier_2d_screen_entered():
	is_on_screen = true


func _on_visible_on_screen_notifier_2d_screen_exited():
	is_on_screen = false

func destroy():
	enemy_count -= 1
	queue_free()
