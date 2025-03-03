extends CharacterBody2D

@export var brush_pivot : Node2D
@export var player_resource : PlayerResource

const SPEED   : float = 300.0
var direction : Vector2 
@export var ink_meter : int = 100

func _ready() -> void:
  player_resource.on_experience_points_change.connect(handle_experience_points_change)

func _unhandled_input(e: InputEvent) -> void:
  if Input.is_action_pressed("q"):
    player_resource.on_experience_points_change.emit()
  
  if Input.is_action_pressed("w"):
    ink_meter += 10
    handle_ink_meter_change()
  
  if Input.is_action_pressed("e"):
    ink_meter -= 10
    handle_ink_meter_change()

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

func handle_level_up() -> void:
  player_resource.level += 1
  player_resource.experience_points = 0

func handle_experience_points_change() -> void:
  player_resource.experience_points += 1
  if player_resource.experience_points >= 100:
    handle_level_up()

func handle_ink_meter_change() -> void:
  ink_meter = clamp(ink_meter, 0, 100)
  if ink_meter <= 0:
    # Handle player death
    queue_free()
