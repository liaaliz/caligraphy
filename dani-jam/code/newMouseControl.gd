extends Node2D
@export var player_resource : PlayerResource
@onready var trail_ref = preload("res://TrailBase.tscn")
@onready var marker_ref = preload("res://TrailMarkers.tscn")
var is_running : bool = false

func _unhandled_input(e: InputEvent) -> void:
  if e is not InputEventMouseButton: return
  if not Input.is_action_just_pressed("left_click"): return
  paint_loop()
  is_running = true

func paint_loop() -> void:
  var brush_trail : Line2D = trail_ref.instantiate()
  var min_distance : float = 10.0 
  var all_points : Array = []
  var candidate_position : Vector2

  get_parent().add_child(brush_trail)
  brush_trail.global_position = get_global_mouse_position()

  brush_trail.add_point(Vector2.ZERO)
  brush_trail.add_point(Vector2.ZERO)

  while Input.is_action_pressed("left_click"):
    await get_tree().process_frame
    if Input.is_action_just_pressed("right_click"):
      fade_brush_trail(brush_trail)
      is_running = false
      return

    if brush_trail.get_point_count() >= 20+1 : continue
    
    brush_trail.set_point_position(brush_trail.points.size() -1, 
    get_global_mouse_position() - brush_trail.global_position)

    var last_point : Vector2 = brush_trail.points[brush_trail.points.size() -1]

    var travelled_distance = abs(last_point.distance_to(brush_trail.points[brush_trail.points.size() -2]))
    if travelled_distance < min_distance : continue

    all_points.append(last_point)
    brush_trail.add_point(last_point)

  for p in all_points: 
    var marker = marker_ref.instantiate()
    get_tree().get_root().get_child(0).add_child(marker)
  fade_brush_trail(brush_trail)
  is_running = false

func fade_brush_trail(_brush_trail : Line2D):
  var fade_to_nothing : Color = _brush_trail.default_color
  fade_to_nothing.a = 0
  var _tween = get_tree().create_tween()

  _tween.tween_property(_brush_trail, "default_color", fade_to_nothing, 0.333)
  _tween.tween_callback(_brush_trail.queue_free)
