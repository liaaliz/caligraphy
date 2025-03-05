class_name MeleeType
extends EnemyType

@export var attack_delay : float

func attack(global_position : Vector2) -> void:
  if on_range_guard(global_position): return
  if not can_attack : return
  
  can_attack = false
  await self.target.get_tree().create_timer(attack_delay)
  can_attack = true

