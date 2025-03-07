extends Node2D
@onready var trail_ref = preload("res://TrailBase.tscn")
@onready var marker_ref = preload("res://TrailMarkers.tscn")
var is_running : bool = false

# Add exported variable to control marker spacing
@export var marker_spacing: int = 5 : 
    set(value):
        marker_spacing = max(1, value)  # Ensure spacing is at least 1

func _unhandled_input(e : InputEvent):
  if e is not InputEventMouseButton: return
  if not Input.is_action_just_pressed("left_click") : return
  paint_loop()
  is_running = true

func paint_loop() -> void:
  var brush_trail : Line2D = trail_ref.instantiate()
  var min_distance : float = 50 
  var all_points: Array = []  # Array to store all points

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
    
    var new_point = get_global_mouse_position() - brush_trail.global_position
    brush_trail.add_point(new_point)
    all_points.append(brush_trail.global_position + new_point)  # Store all points

    if brush_trail.get_point_count() < 20: continue
    brush_trail.remove_point(0)
  
  # Create filtered array using the marker_spacing variable
  var filtered_points: Array = []
  for i in range(all_points.size()):
    if (i + 1) % marker_spacing == 0:  # Use the exported variable
      filtered_points.append(all_points[i])

  # Create markers from filtered points
  for point in filtered_points:
    var marker = marker_ref.instantiate()
    get_tree().get_root().get_child(0).add_child(marker)
    marker.global_position = point

  brush_trail.queue_free()
  is_running = false
