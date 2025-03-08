extends Area2D
signal has_died 

func _ready() -> void:
  area_entered.connect(handle_hit)

func handle_hit(_other: Area2D):
  splash_ink(_other.name)
  on_die()

func splash_ink(_other_name : String):
  print("ink_splashed by " , _other_name)

func on_die():
  has_died.emit()
