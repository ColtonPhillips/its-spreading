class_name PlayerStatsComponent
extends ActorStatsComponent

var pstats: PlayerStats
func _ready():
	super()
	pstats = stats
	exp = pstats.exp
	

# Create the health variable and connect a setter
var max_exp: int = 100
var exp: int = 0:
	set(value):
		exp = value
		
		# Signal out that the exp has changed
		exp_changed.emit()
		
		# Signal out when exp is at 0
		if exp >= max_exp: level_up.emit()

# Create our signals for exp
signal exp_changed() # Emit when the exp value has changed
signal level_up() # Emit when there is no health left
