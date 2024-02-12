extends StaticBody2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@export var isShdaowRotated := false
@onready var shadow: Sprite2D = $Sprite2D/Shadow

#XXX made this in a rush!
var health := 6
var max_health := health

func amount_burnt() -> int:
	return max_health - health
	
func percent_burnt() -> float:
	return (max_health - health) / max_health
# Called when the node enters the scene tree for the first time.

func amount_per_health() -> int:
	if (max_health == health + 1):
		return 2
	return 5

func _ready():
	cpu_particles_2d.amount = amount_per_health()
	if isShdaowRotated:
		shadow.rotate(0.5 * PI)
		shadow.position.x += 10 + 40 - 2 - 2
		shadow.scale *= 0.9
		shadow.position.y += 6 + 12 + 7 - 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health != max_health:
		sprite_2d.modulate = Color(1 + percent_burnt() * 0.5, 0.8, 0.8, 1)
		cpu_particles_2d.emitting = true
	if health < 0:
		die()
		
func die():
	queue_free()

func reduce_health():
	health -= 1

func _on_hurtbox_component_hurt(hitbox):
	if health == max_health:
		Global.delay_create_loop(self, 8, reduce_health)
	health -= 1
	cpu_particles_2d.amount = amount_burnt() * amount_per_health()
