extends Node
@onready var game_resource : GameResource = preload("res://code/resources/GameResource.tres")
@onready var last_game_state : GameResource.GAME_STATE 
@onready var start_menu : Control  = preload("res://scenes/Menus/StartMenu.tscn").instantiate()
@onready var dead_menu : Control   = preload("res://scenes/Menus/DeadMenu.tscn").instantiate()
@onready var update_menu : Control = preload("res://scenes/Menus/Upgrade.tscn").instantiate()  
@onready var gameplay_scene : Node2D = preload("res://TestScene.tscn").instantiate()
@onready var canvas_layer : CanvasLayer = get_node("CanvasLayer")

func _ready() -> void :
  game_resource.connect("on_game_state_change", handle_game_state_change)
  handle_game_state_change(GameResource.GAME_STATE.START_MENU)

func handle_game_state_change(state : GameResource.GAME_STATE, _delay : float = 0.0) -> void:
  await get_tree().create_timer(_delay).timeout

  if last_game_state != null:
    exit_last_state(last_game_state)
  match state:
    GameResource.GAME_STATE.START_MENU:
      add_to_canvas(start_menu)
    GameResource.GAME_STATE.GAMEPLAY:
      add_child(gameplay_scene)
    GameResource.GAME_STATE.END_MENU:
      add_to_canvas(dead_menu)

  last_game_state = state

func exit_last_state(state : GameResource.GAME_STATE):	
  match state:
    GameResource.GAME_STATE.START_MENU:
      canvas_layer.layer = -1
      canvas_layer.remove_child(start_menu)

    GameResource.GAME_STATE.GAMEPLAY:
      canvas_layer.layer = 0

    GameResource.GAME_STATE.END_MENU:
      canvas_layer.layer = -1

func add_to_canvas(_node : Node) -> void:
  canvas_layer.add_child(_node)
