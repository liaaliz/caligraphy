class_name GameResource
extends Resource

enum GAME_STATE {
  START_MENU,
  IN_GAME,
  PAUSED,
  LEVEL_UP,
  END_MENU,
}

var player : PlayerResource
var game_state : GAME_STATE = GAME_STATE.START_MENU
#var enemies : Array[Enemy]
#Turn into a options array

var last_enemy_id : int = 0
var on_game_state_change : Signal
var on_level_up : Signal
