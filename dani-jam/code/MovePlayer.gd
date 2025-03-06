extends CharacterBody2D
@export var brush_pivot : Node2D

const SPEED   : float = 300.0
var direction : Vector2 
@export var ink_meter : int = 100

func _unhandled_input(e: InputEvent) -> void:
  if not e is InputEventMouseMotion: return
  brush_pivot.z_index = sign(brush_pivot.rotation) 

func _process(delta: float) -> void: 
  var new_brush_angle = brush_pivot.position.angle_to_point(get_global_mouse_position())
  brush_pivot.global_rotation = lerp_angle(brush_pivot.global_rotation, new_brush_angle, delta * 7)

func _physics_process(_delta: float) -> void:
  direction = Vector2(
  Input.get_axis("ui_left","ui_right"),
  Input.get_axis("ui_up",  "ui_down" )
  )

  move_and_slide()
  var _smooth : float = 0.2
  velocity = lerp(velocity, direction.normalized() * SPEED, _smooth)


func handle_ink_meter_change() -> void:
  ink_meter = clamp(ink_meter, 0, 100)
  if ink_meter <= 0:
    # Handle player death
    queue_free()
