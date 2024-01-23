extends StaticBody2D
@onready var sprite_2d = $Sprite2D
@onready var cpu_particles_2d = $CPUParticles2D
#XXX made this in a rush!
var health = 6
var max_health = health

func amount_burnt():
	return max_health - health
	
func percent_burnt():
	return (max_health - health) / max_health
# Called when the node enters the scene tree for the first time.

func amount_per_health():
	if (max_health == health + 1):
		return 2
	return 5

func _ready():
	cpu_particles_2d.amount = amount_per_health()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health != max_health:
		sprite_2d.modulate = Color(1 + percent_burnt() * 0.5, 0.8, 0.8, 1)
		cpu_particles_2d.emitting = true
	if health < 0:
		die()	
		
func die():
	queue_free()

func _on_hurtbox_component_hurt(hitbox):
	health -= 1
	cpu_particles_2d.amount = amount_burnt() * amount_per_health()
