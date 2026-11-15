extends CharacterBody2D

@export var target: Node2D
@export var speed: float = 400.0
<<<<<<< HEAD

func _physics_process(delta: float) -> void:
	velocity = Vector2(target.position.x - position.x, target.position.y - position.y).normalized() * speed
	move_and_slide()
=======
@export var max_health: int = 100
@export var damage: int = 20
@export var health: int = max_health

func _physics_process(delta: float) -> void:
	velocity = Vector2(target.position.x - position.x, target.position.y - position.y).normalized() * speed
	var collision = move_and_collide(velocity * delta)
	if(collision):
		var collider = collision.get_collider()
		if collider.is_in_group("Player") and !collider.get("rolling"):
			collider.set("health", collider.get("health") - 20)
			print(collider.get("health"))
>>>>>>> c4f533a (idk :()
