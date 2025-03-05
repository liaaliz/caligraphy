extends Node
@export_range(2, 30) var spawn_interval : float

var spawn_tick : float
@export var target : CharacterBody2D
@export var ghost_scene : PackedScene
@export var book_scene : PackedScene

func add_enemy_to_scene(new_enemy: Enemy) -> void:
  var enemy_node = new_enemy.instantiate() 
  enemy_node.target = target
  randomize()
  enemy_node.position.x = randf_range(0, get_tree().get_root().get_visible_rect().size.x)
  enemy_node.position.y = randf_range(0, get_tree().get_root().get_visible_rect().size.y)
  get_tree().get_root().add_child(enemy_node)

func _process(delta : float) -> void:
  spawn_tick += delta
  if spawn_tick < spawn_interval: return
  randomize()
  var enemy_to_spawn : Enemy = book_scene.instantiate() if ((randi() % 10) + 1) > 7 else ghost_scene.instantiate()
  add_enemy_to_scene(enemy_to_spawn)
  spawn_tick = 0
  return
