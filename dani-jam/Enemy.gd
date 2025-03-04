extends Node2D

class_name Enemy

var id : int
var health : int
var damage : int
var speed : int
var attack_range : int
var attack_damage : int
var attack_speed : int
var target : Node2D
var game_resource : GameResource

func _init(game_res: GameResource) -> void:
	target = get_tree().get_first_node_in_group("player")
	game_resource = game_res
	id = game_resource.last_enemy_id
	game_resource.last_enemy_id += 1
	game_resource.enemies.append(self)

func _process(delta: float) -> void:
	if target and health > 0:  # Only process if alive
		var direction = (target.global_position - global_position).normalized()
		global_position += direction * speed * delta

func attack() -> void:
	if target and health > 0 and global_position.distance_to(target.global_position) <= attack_range:
		target.take_damage(attack_damage)

func take_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		die()

func die() -> void:
	# Set all properties to null/zero instead of removing from array
	health = 0
	damage = 0
	speed = 0
	attack_range = 0
	attack_damage = 0
	attack_speed = 0
	target = null
	# Optionally add visual/audio effects for death
	queue_free()

class Ghost extends Enemy:
	func _init(game_res: GameResource) -> void:
		super._init(game_res)
		attack_range = 1
		speed = 100
		health = 50
		attack_damage = 10

	func attack() -> void:
		if target and health > 0 and global_position.distance_to(target.global_position) <= attack_range:
			var projectile = Projectile.new()
			projectile.damage = attack_damage
			projectile.global_position = global_position
			projectile.direction = (target.global_position - global_position).normalized()
	#		projectile.sprite = preload("res://path/to/ghost_projectile.png")  # Set ghost projectile sprite
			get_parent().add_child(projectile)

class Book extends Enemy:
	func _init(game_res: GameResource) -> void:
		super._init(game_res)
		attack_range = 10
		speed = 50
		health = 30
		attack_damage = 5

	func attack() -> void:
		if target and health > 0 and global_position.distance_to(target.global_position) <= attack_range:
			var projectile = Projectile.new()
			projectile.damage = attack_damage
			projectile.global_position = global_position
			projectile.direction = (target.global_position - global_position).normalized()
	#		projectile.sprite = preload("res://path/to/book_projectile.png")  # Set book projectile sprite
			projectile.speed = 150  # Example of different speed
			get_parent().add_child(projectile)