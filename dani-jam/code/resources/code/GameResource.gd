class_name GameResource
extends Resource

enum GAME_STATE {
  START_MENU,
  GAMEPLAY,
  PAUSED,
  LEVEL_UP,
  END_MENU,
}

var game_state : GAME_STATE 
var enemies : Array[Enemy]
var last_enemy_id : int = 0
signal on_game_state_change
signal on_level_up

var game_time : float

func change_state(new_state):
  game_state = new_state
  on_game_state_change.emit(game_state)
