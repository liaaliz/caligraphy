class_name GameResource
extends Resource

enum GAME_STATE {
  START_MENU,
  IN_GAME,
  PAUSED,
  LEVEL_UP,
  END_MENU,
}
var game_state : GAME_STATE 
var enemies : Array[Enemy]
var last_enemy_id : int = 0
var on_game_state_change : Signal
var on_level_up : Signal

var game_time : float

func change_state(new_state):
  game_state = new_state
  on_game_state_change.emit(game_state)
