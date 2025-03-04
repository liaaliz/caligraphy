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
#Turn into a options array
var enemies : Array[Enemy] = []:
    set(value):
        if value.size() <= 500:
            enemies = value
        else:
            enemies = value.slice(0, 499)  # Keep only first 500 elements

var last_enemy_id : int = 0
var on_game_state_change : Signal
var on_level_up : Signal