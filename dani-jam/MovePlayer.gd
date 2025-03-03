extends CharacterBody2D

@export var brush_pivot : Node2D

const SPEED       : float = 300.0
var direction     : Vector2 

func _unhandled_input(e: InputEvent) -> void:
  if not e is InputEventMouseMotion: return

  if sign(brush_pivot.rotation) > 0:
    brush_pivot.z_index = 1
    return

  brush_pivot.z_index = -1

func _unhandled_key_input(e : InputEvent) -> void:
  if not e.is_action_type(): return
  ##if player is on stagger : return
  direction = Vector2(
    Input.get_axis("ui_left","ui_right"),
    Input.get_axis("ui_up",  "ui_down")
  )

func _process(delta: float) -> void: 
  var new_brush_angle = brush_pivot.position.angle_to_point(get_global_mouse_position())
  brush_pivot.global_rotation = lerp_angle(brush_pivot.global_rotation, new_brush_angle, delta * 7)

func _physics_process(_delta: float) -> void:
    move_and_slide()
    if direction: 
      velocity = direction.normalized() * SPEED 
      return
    velocity = Vector2.ZERO
