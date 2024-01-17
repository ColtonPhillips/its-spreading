class_name PlayerStatsComponent
extends ActorStatsComponent

var exp = 1
var pstats: PlayerStats
func _ready():
	pstats = stats
	exp = pstats.exp
