extends Control 
@export var options_swipe : Node2D
@export var start_swipe : Node2D
@export var exit_swipe : Node2D

@onready var game_resource : GameResource = preload("res://code/resources/GameResource.tres")

func _ready() -> void:
  start_swipe.connect("has_painted", game_resource.change_state.bind(game_resource.GAME_STATE.IN_GAME))
