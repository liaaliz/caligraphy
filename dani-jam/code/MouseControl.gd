extends Node2D
@onready var trail_ref = preload("res://TrailBase.tscn")
var is_running : bool = false

func _unhandled_input(e : InputEvent):
  if e is not InputEventMouseButton: return
  if not Input.is_action_just_pressed("left_click") : return
  paint_loop()
  is_running = true

func paint_loop() -> void:
  var brush_trail : Line2D = trail_ref.instantiate()
  var min_distance : float = 50 

  get_tree().get_root().get_child(0).add_child(brush_trail)
  brush_trail.global_position = get_global_mouse_position()
  brush_trail.add_point(Vector2.ZERO)
  var last_point = brush_trail.points[brush_trail.points.size() -1]

  brush_trail.add_point(Vector2.ZERO)

  while Input.is_action_pressed("left_click"):
    await get_tree().process_frame
    if Input.is_action_just_pressed("right_click"): break

    brush_trail.set_point_position(brush_trail.points.size() -1, get_global_mouse_position() - brush_trail.global_position)

    if abs(last_point.distance_to(brush_trail.points[brush_trail.points.size() -1])) < min_distance: continue
    brush_trail.add_point(get_global_mouse_position() - brush_trail.global_position)

    if brush_trail.get_point_count() < 20: continue
    brush_trail.remove_point(0)
  brush_trail.queue_free()
  is_running = false
