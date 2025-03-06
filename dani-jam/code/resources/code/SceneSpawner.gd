extends Node
@onready var game_resource : GameResource = preload("res://code/resources/GameResource.tres")
@onready var last_game_state : GameResource.GAME_STATE = GameResource.GAME_STATE.START_MENU
@onready var start_menu : Control  = preload("res://scenes/Menus/StartMenu.tscn").instantiate()
@onready var dead_menu : Control   = preload("res://scenes/Menus/DeadMenu.tscn").instantiate()
@onready var update_menu : Control = preload("res://scenes/Menus/Upgrade.tscn").instantiate()  
@onready var gameplay_scene : Node2D = preload("res://TestScene.tscn").instantiate()

func _ready() -> void :
  game_resource.connect("on_game_state_change", handle_game_state_change)
  get_node("CanvasLayer").add_child(start_menu)

func handle_game_state_change(state : GameResource.GAME_STATE) -> void:
  print("around the world")
  exit_last_state(state)
  match state:
    GameResource.GAME_STATE.IN_GAME:
      add_child(gameplay_scene)

func exit_last_state(state : GameResource.GAME_STATE) : pass	
