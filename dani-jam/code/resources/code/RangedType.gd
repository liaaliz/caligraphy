class_name RangedType
extends EnemyType
@export_enum("NORMAL", "CHASING") var bullet : String
@export_range(1, 3) var reload_time  : float

var bullet_scene : PackedScene

func ready() -> void:
  match bullet:
    "NORMAL":
      bullet_scene = preload("res://scenes/Bullets/NormalBullet.tscn")

func attack(global_position : Vector2) -> void:
  if on_range_guard(global_position): return
  if not self.can_attack : return
  self.can_attack = false

  var new_projectile = bullet_scene.instantiate()
  new_projectile.target = target
  new_projectile.global_position = global_position
  
  self.target.get_tree().get_root().add_child(new_projectile)
  
  await self.target.get_tree().create_timer(self.reload_time).timeout
  self.can_attack = true
