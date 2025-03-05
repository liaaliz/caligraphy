class_name PlayerResource
extends Resource
@export var level             : int = 1
@export var experience_points : int = 0

var on_experience_change : Signal
var on_stats_change      : Signal
