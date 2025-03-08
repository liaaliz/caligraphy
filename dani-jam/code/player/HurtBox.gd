extends Area2D
signal has_died 

func _ready() -> void:
  area_entered.connect(handle_hit)

func handle_hit(_other: Area2D):
  splash_ink()
  on_die()

func splash_ink():
  print("ink_splashed")

func on_die():
  has_died.emit()
