extends Control
@onready var mouse_control : Node2D = get_tree().get_root().get_node("MouseControl")
@onready var game_resource : GameResource = preload("res://code/resources/GameResource.tres")

@export var buttons : Array[Node2D]

var selected_buttons: Array[Area2D] = []  # Track selected buttons
var is_running: bool = false   # Prevent re-entrancy

func _ready() -> void:
  for i in range(buttons.size()):
    buttons[i].connect("on_end_swipe", Callable(self, "_on_button_selected").bind(buttons[i]))

func _on_button_selected(button: Node2D) -> void:
  if is_running:
    return  # Prevent re-entrancy
  is_running = true

  if not button:
    is_running = false
    return		

  selected_buttons.append(button)

  if _validation_guard(): 
    _break_and_shake()
    return
  _selected_button_action(button)
  _clear_selection()
  is_running = false

func _validation_guard() -> bool:
  if selected_buttons.size()  != 3 : return true
  var name_check = selected_buttons[0].get_parent().name
  return selected_buttons.all(func(btn): return btn.get_parent().name == name_check)

func _selected_button_action(button: Node2D) -> void:
  button.handle_end_swipe()

func _clear_selection() -> void:
  selected_buttons.clear()
  for button in buttons:
    if button and button.has_method("reset"):
      button.call("reset")

func _break_and_shake(): 
  _clear_selection()
