extends Node
@export var trail_ref  : PackedScene
@export var blob_ref : PackedScene
@export var trail_step : int = 5
@export var ink_meter  : int = 100

func _unhandled_input(e : InputEvent):
  if e is not InputEventMouseButton: return
  if not Input.is_action_just_pressed("left_click") : return
  trail_loop()

func trail_loop() -> void:
  var mouse_start_position : Vector2 = get_viewport().get_global_mouse_position()
  var brush_trail : Line2D = trail_ref.instantiate()
  get_tree().get_root().add_child(brush_trail)

  brush_trail.add_point(mouse_start_position)
  while Input.is_action_pressed("left_click"):

  await get_tree().process_frame


