extends CharacterBody2D

@export var speed: float
@export var roll_limit: float
@export var launch_speed: float
@export var max_health: float
@export var roll_damage: float
@export var animation_player: AnimatedSprite2D
var health: float

var jump_strength: float = 1

var rolling: bool = false

# launch the player
func launch(direction: Vector2):
	rolling = true;
	velocity += direction;

func _ready():
	health = max_health

func _physics_process(delta: float):
	var input: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var mouse_vector: Vector2 = get_global_mouse_position()
	
	# animations
	if rolling:
		animation_player.play("player_dash")
	else:
		if health > (max_health / 3) * 2:
			animation_player.play("player_idle_1")
		elif health > (max_health / 3):
			animation_player.play("player_idle_2")
		else:
			animation_player.play("player_idle_3")

	# all the movements
	if !rolling and !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		velocity = input * speed;
		jump_strength = 1.0
	elif !rolling and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		launch(Vector2(mouse_vector.x - position.x, mouse_vector.y - position.y).normalized() * launch_speed)
	else:
		velocity *= 0.9

	# deinitialization (DO NOT DO ANYTHING AFTER)
	if velocity.length() > roll_limit:
		rolling = true
	else:
		rolling = false
	
	var collision = move_and_collide(velocity * delta)
	if collision and rolling:
		print("collision while rolling")
		launch(collision.get_normal() * jump_strength * launch_speed)
		jump_strength -= 0.1
		var collider = collision.get_collider()

		if collider.is_in_group("Enemies"):
			collider.set("health", collider.get("health") - roll_damage)
			print("damaged enemy")
			print(collider.get("health"))
