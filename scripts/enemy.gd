extends CharacterBody2D

@export var target: Node2D
@export var speed: float = 400.0

func _physics_process(delta: float) -> void:
	velocity = Vector2(target.position.x - position.x, target.position.y - position.y).normalized() * speed
	move_and_slide()
