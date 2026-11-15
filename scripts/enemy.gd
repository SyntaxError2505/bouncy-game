extends CharacterBody2D

@export var target: Node2D
@export var speed: float = 400.0
@export var max_health: int = 100
@export var damage: int = 20
@export var health: int
@export var prefered_distance: float = 200.0
@export var distance_buffer: float = 50.0

func _ready():
	health = max_health

func _physics_process(delta: float) -> void:
	# death
	if health <= 0:
		queue_free()

	var dir_vector = Vector2(target.position.x - position.x, target.position.y - position.y)
	if dir_vector.length() > prefered_distance:
		# to far away
		velocity = dir_vector.normalized() * speed;
	else:
		if dir_vector.length() + distance_buffer < prefered_distance:
			# to close
			velocity = dir_vector.normalized() * speed * -1
		else:
			# to close but within buffer
			velocity = Vector2.ZERO
	var collision = move_and_collide(velocity * delta)

	if(collision):
		var collider = collision.get_collider()
		if collider.is_in_group("Player") and !collider.get("rolling"):
			collider.set("health", collider.get("health") - 20)
			print(collider.get("health"))
