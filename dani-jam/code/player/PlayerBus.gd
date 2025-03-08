extends Node
@onready var game_resource  : GameResource = preload("res://code/resources/GameResource.tres")
@export var player_resource : PlayerResource
@export var movement        : CharacterBody2D
#@export var animation      : AnimationTree 
@export var hurtbox         : Area2D
@export var brush_attack    : Node 

func _ready() -> void:
  ready_deferred.call_deferred()

func ready_deferred() -> void:
  hurtbox.connect("has_died", handle_has_died)
  player_resource.on_experience_change.connect(handle_experience_change)

func _exit_tree() -> void:
  game_resource.on_game_state_change.emit(game_resource.GAME_STATE.END_MENU, 0.333)

func check_ink_meter() -> float:
  return brush_attack.ink_meter

func zero_ink_meter() -> void:
  brush_attack.ink_meter = 0

func handle_has_died(): 
  queue_free()

func process_level_up() -> void:
  player_resource.level += 1
  player_resource.experience_points = 0

func handle_experience_change() -> void:
  player_resource.experience_points += 1
  if player_resource.experience_points >= 100:
    process_level_up()


