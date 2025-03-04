extends Area2D

class_name Projectile

var damage : int
var speed : float = 200.0
var direction : Vector2
var sprite : Texture

func _ready() -> void:
    $Sprite2D.texture = sprite  # Assuming you have a Sprite2D node

func _process(delta: float) -> void:
    global_position += direction * speed * delta

func _on_body_entered(body: Node) -> void:
    if body.is_in_group("player"):
        body.take_damage(damage)
        queue_free() 