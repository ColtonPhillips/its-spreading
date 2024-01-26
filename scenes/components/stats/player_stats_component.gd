class_name PlayerStatsComponent
extends ActorStatsComponent

var pstats: PlayerStats
func _ready():
	super()
	pstats = stats
	exp = pstats.exp
	level = pstats.level
	

# Create the health variable and connect a setter
var max_exp: int = 100
var exp: int = 0:
	set(value):
		exp = value
		
		# Signal out when exp is at 0
		if exp >= max_exp: 
			level += 1
			exp = exp - max_exp
			max_exp *= 1.1
			speed *= 1.1
			level_up.emit()
			
		# Signal out that the exp has changed
		exp_changed.emit()
		

# Create our signals for exp
signal exp_changed() # Emit when the exp value has changed
signal level_up() # Emit when there is no health left

var level: int = 1

var critical_hit = 0.02 # rate

func upgrade_player(upgrade, player):
	match upgrade.type:
		"damage":
			player.stats_component.damage *= 1.12
		"speed":
			player.stats_component.speed *= 1.1
		"range":
			player.pickup_range_collision_shape_2d.shape.radius *= 1.5
		"critical_hit":
			critical_hit *= 1.5
		"heal":
			player.stats_component.hp += 15
