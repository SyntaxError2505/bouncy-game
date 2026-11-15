extends CharacterBody2D

@export var target: Node2D
@export var bullet_scene: PackedScene
@export var speed: float
@export var max_health: int
@export var damage: int
@export var health: int
@export var prefered_distance: float
@export var distance_buffer: float
@export var animation_player: AnimatedSprite2D
@export var shoot_cooldown: float
@export var bullet_speed: float
@export var spawn_buffer: float

var can_shoot: bool = true;

func shoot():
	if can_shoot:
		var bullet_instance = bullet_scene.instantiate()
		bullet_instance.global_transform = global_transform
		bullet_instance.speed = bullet_speed
		bullet_instance.damage = damage
		bullet_instance.direction = Vector2(target.position.x - position.x, target.position.y - position.y).normalized()
		get_parent().add_child(bullet_instance)
		can_shoot = false
		await get_tree().create_timer(shoot_cooldown).timeout
		can_shoot = true

func _ready():
	health = max_health

func _physics_process(delta: float) -> void:
	# animation
	animation_player.play("default")

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
			# to close but within buffer2
			velocity = Vector2.ZERO
			shoot()
	move_and_slide()
