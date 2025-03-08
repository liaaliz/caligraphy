extends Node
@export_range(2, 30) var spawn_interval : float

var spawn_tick : float
@export var enemy_pool : Node
@export var target : CharacterBody2D
@export var enemies_to_spawn: Array[PackedScene]

func add_enemy_to_scene(new_enemy: Enemy) -> void:
  if target == null : return
  new_enemy.target = target
  randomize()
  new_enemy.position.x = randf_range(0, get_tree().get_root().get_visible_rect().size.x)
  new_enemy.position.y = randf_range(0, get_tree().get_root().get_visible_rect().size.y)
  add_child(new_enemy)

func _process(delta : float) -> void:
  spawn_tick += delta
  if spawn_tick < spawn_interval: return
  randomize()
  var enemy_to_spawn : Enemy = enemies_to_spawn[randi() % enemies_to_spawn.size()].instantiate() as Enemy
  add_enemy_to_scene(enemy_to_spawn)
  spawn_tick = 0
  return
