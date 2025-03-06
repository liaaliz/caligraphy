class_name Projectile
extends Area2D

@export_range(10, 40) var lifetime : float
@export var speed  : float = 200.0
var target         : CharacterBody2D 
var direction      : float

func _ready() -> void:
  direction = global_position.angle_to_point(target.global_position)
  rotation  = direction
  
  await get_tree().create_timer(lifetime).timeout
  end_bullet()

func _process(delta: float) -> void:
  global_position += Vector2.from_angle(direction).normalized() * speed * delta

func end_bullet():
  queue_free()
