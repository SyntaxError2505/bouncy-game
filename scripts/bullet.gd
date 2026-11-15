extends CharacterBody2D

@export var speed: float
@export var damage: float
@export var direction: Vector2

func _ready():
	position += direction * 50

func _physics_process(delta: float) -> void:
	var movement: Vector2 = direction.normalized() * speed * delta
	var collision = move_and_collide(movement)
	if collision:
		print("bullet hit %s" % [collision.get_collider().get_class()])
		var collider = collision.get_collider()
		if collider.is_in_group("Player"):
			print("bullet hit player")
			collider.set("health", collider.get("health") - damage)
		queue_free()
