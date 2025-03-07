extends Node2D
@export var mouse_controller : Node2D
@onready var confirm : Array = [false, false, false]
@onready var game_resource = preload("res://code/resources/GameResource.tres")
var on_end_swipe : Signal
var is_selected: bool = false  # Track if this button is selected

func _ready() -> void:
  # Connect to mouse controller's marker signal
  if mouse_controller:
    if mouse_controller.has_signal("marker_created"):
      mouse_controller.connect("marker_created", _on_marker_created)
    else:
      push_error("MouseController is missing 'marker_created' signal")
  
  # Connect area signals
  for index in range(get_child_count()):
    var child = get_child(index)
    if child is Area2D:
      child.connect("area_entered", _on_area_entered.bind(index))
    else:
      push_error("Child node is not an Area2D: ", child.name)

func _on_marker_created(marker: Area2D) -> void:
  # Check for collision with this button's areas
  for area in get_children():
    if area is Area2D and area.overlaps_area(marker):
      is_selected = true
      print("Button selected via collision: ", name)
      return

func _on_area_entered(area: Area2D, index: int) -> void:
  if area.is_in_group("marker"):  # Ensure it's a marker
    confirm[index] = true
    #print("Area ", index, " confirmed by marker")
    check_swipe_complete()

func check_swipe_complete() -> void:
  if confirm.all(func(check): return check):
    on_end_swipe.emit()
    reset()

func reset() -> void:
  confirm = confirm.map(func(check: bool): return false)
  is_selected = false
  print("Button reset: ", name)
