extends Area2D
var has_died : Signal 
var is_sonic : bool

func _ready() -> void:
  body_entered.connect(handle_hit)

func handle_hit(_other: CharacterBody2D):
  #if get_parent().check_ink_meter() < 0:
   # splash_ink()
    #return
  on_die()

func splash_ink():
  print("ink_splashed")

func on_die():
  has_died.emit()
