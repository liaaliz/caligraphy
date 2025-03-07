extends Node
enum SCREEN{DEAD_MENU, GAMEPLAY, START_SCENE, LEVEL_UP_SCENE}

@onready var start_menu : Control  = preload("res://scenes/Menus/StartMenu.tscn").instantiate()
@onready var dead_menu : Control   = preload("res://scenes/Menus/DeadMenu.tscn").instantiate()
@onready var level_up_scene : Control = preload("res://scenes/Menus/Upgrade.tscn").instantiate()  
@onready var gameplay_scene : Node2D = preload("res://TestScene.tscn").instantiate()

func _ready() -> void :
  add_child(gameplay_scene)

func exit_last_state(state : SCREEN) : pass	

