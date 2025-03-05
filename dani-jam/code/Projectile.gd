class_name Projectile
extends Area2D

@export var speed  : float = 200.0
var target         : CharacterBody2D 
var direction      : float

func _ready() -> void:
  direction = global_position.angle_to_point(target.global_position)
  rotation  = direction

func _process(delta: float) -> void:
  global_position += Vector2.from_angle(direction).normalized() * speed * delta
