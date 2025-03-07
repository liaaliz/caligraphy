extends Node
@onready var main_scene     : Node = get_tree().get_root().get_child(0) 
@export var player_resource : PlayerResource
@export var movement        : CharacterBody2D
#@export var animation      : AnimationTree 
@export var hurtbox         : Area2D
@export var brush_attack    : Node 

func _ready() -> void:
  ready_deferred.call_deferred()

func ready_deferred() -> void:
  hurtbox.has_died.connect(handle_has_died)
  player_resource.on_experience_change.connect(handle_experience_change)

func check_ink_meter() -> float:
  return brush_attack.ink_meter

func zero_ink_meter() -> void:
  brush_attack.ink_meter = 0

func handle_has_died(): 
  main_scene.call_screen(main_scene.SCREENS.DEAD_SCREEN)
  queue_free()

func process_level_up() -> void:
  player_resource.level += 1
  player_resource.experience_points = 0

func handle_experience_change() -> void:
  player_resource.experience_points += 1
  if player_resource.experience_points >= 100:
    process_level_up()
