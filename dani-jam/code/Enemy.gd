class_name Enemy
extends CharacterBody2D 

@export var type : EnemyType 
@onready var game_resource : GameResource = preload("res://code/resources/GameResource.tres")

var id : int
var target : CharacterBody2D

func _ready() -> void:
  game_resource.enemies.insert(id, self)
  type = type
  type.target = target
  type.ready()

func _physics_process(delta : float) -> void:
  if target == null : return
  move_to_target(delta)
  attack()
  type.physics_process(delta)

func attack() -> void:
  if target == null : return
  type.attack(global_position)

func die() -> void:
  type.die()
  game_resource.last_enemy_id = id
  get_parent().remove_child(self)

func move_to_target(delta : float) -> void:
  var direction = (target.global_position - global_position).normalized()
  global_position += direction * type.speed * delta
