extends Node

@export var spawn_interval: float = 5.0  # Developer can edit this in the editor
@export var enemy1_scene: PackedScene    # Set Enemy1 scene in editor
@export var enemy2_scene: PackedScene    # Set Enemy2 scene in editor

var time_since_last_spawn: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_since_last_spawn += delta
	
	if time_since_last_spawn >= spawn_interval:
		spawn_enemy()
		time_since_last_spawn = 0.0

func spawn_enemy() -> void:
	var enemy_scene: PackedScene
	
	# Random selection with 3:1 ratio for Enemy1:Enemy2
	if randf() < 0.75:
		enemy_scene = enemy1_scene
	else:
		enemy_scene = enemy2_scene
	
	if enemy_scene:
		var enemy_instance = enemy_scene.instantiate()
		add_child(enemy_instance)
