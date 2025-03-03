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
var enemies : Array[Enemy]
var last_enemy_id : int = 0
var on_level_up : Signal
var on_game_state_change : Signal

class Enemy extends GameResource :
	var id : int
	var health : int
	var damage : int
	var speed : int
	var attack_range : int
	var attack_damage : int
	var attack_speed : int

	func _init() -> void:
		pass

	func add_enemy(enemy: Enemy) -> void:
		enemies.append(enemy)

	func remove_enemy(enemy: Enemy) -> void:
		enemies.remove_at(enemy.id)
