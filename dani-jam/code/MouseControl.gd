extends Node
const trail_ref = preload("res://TrailBase.tscn")

func _unhandled_input(e : InputEvent):
  if e is not InputEventMouseButton: return
  if not Input.is_action_just_pressed("left_click") : return
  trail_loop()

func trail_loop() -> void:
  var mouse_start_position : Vector2 = get_viewport().get_global_mouse_position()
  var brush_trail : Line2D = trail_ref.instantiate()
  get_tree().get_root().add_child(brush_trail)
  var min_distance : float = 10
  
  brush_trail.add_point(mouse_start_position)

  var last_point = brush_trail.points[brush_trail.points.size() -1]
  
  brush_trail.add_point(mouse_start_position)
  var cur_point = brush_trail.points[brush_trail.points.size() -1]

  while Input.is_action_pressed("left_click"):
    if Input.is_action_just_pressed("right_click"): break
    await get_tree().process_frame

