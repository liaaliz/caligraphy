extends Node2D
@export var mouse_controller : Node2D
@onready var confirm : Array = [false, false, false]
@onready var game_resource = preload("res://code/resources/GameResource.tres")
var on_end_swipe : Signal

func _ready() -> void:
  for index in range(get_child_count()):
    get_child(index).connect("mouse_entered", check_in_parts.bind(get_child(index), index))

func _process(delta : float) -> void:
  if confirm.all(func(check): return check):
    on_end_swipe.emit()
    reset()

func check_in_parts(area2D: Area2D, index : int) -> void:
  print("here")
  area2D.monitoring = false
  confirm[index] = true

func reset() -> void:
  confirm = confirm.map(func(check: bool): return false)
  get_children().map(func(area): area.monitoring = true)
