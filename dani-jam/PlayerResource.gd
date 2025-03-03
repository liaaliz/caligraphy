class_name PlayerResource
extends Resource

# Called when the node enters the scene tree for the first time.

# Pending:
	# Add experience points
	# Add ink_meter
	# Add health
	# Add stats

@export var level : int = 1
@export var experience_points : int = 0
# pending stats

var on_experience_points_change : Signal
var on_stats_change : Signal