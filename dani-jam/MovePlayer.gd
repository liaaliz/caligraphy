extends CharacterBody2D

@export var brush_pivot : Node2D

const SPEED   : float = 300.0
var direction : Vector2 

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

  if direction != Vector2.ZERO:
    oscilate_sprite(get_node("Sprite"))

func oscilate_sprite(sprite : MeshInstance2D):
  var _tween : Tween = get_tree().create_tween()

  _tween.tween_property(sprite, "rotation", TAU * 0.1666, 0.333).set_trans(Tween.TRANS_SPRING)
  _tween.tween_property(sprite, "rotation", -TAU * 0.1666, 0.333).set_trans(Tween.TRANS_SPRING)
  
  await _tween.finished

  if direction != Vector2.ZERO:
    oscilate_sprite(sprite)
    return
  get_tree().create_tween().tween_property(sprite, "rotation", 0, 0.333).set_trans(Tween.TRANS_SPRING)

