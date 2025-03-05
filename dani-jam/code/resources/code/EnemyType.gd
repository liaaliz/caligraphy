class_name EnemyType
extends Resource 

@export var speed : int
@export var atk_range : int

var can_attack : bool = true
var target : CharacterBody2D

func physics_process(delta : float) -> void : pass
func ready() -> void : pass
func attack(global_position : Vector2) -> void : pass
func die() -> void : pass

func on_range_guard(global_position : Vector2) -> bool:
  if global_position.distance_to(target.global_position) > atk_range : return true
  return false
