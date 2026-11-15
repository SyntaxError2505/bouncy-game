extends CharacterBody2D

<<<<<<< HEAD
@export var speed: float = 300.0;
@export var roll_limit: float = 600.0;
@export var launch_speed: float = 3000.0;
=======
@export var speed: float = 300.0
@export var roll_limit: float = 600.0
@export var launch_speed: float = 3000.0
@export var max_health: float = 100.0
@export var roll_damage: float = 50
var health: float = max_health
>>>>>>> c4f533a (idk :()
var jump_strength: float = 1

var rolling: bool = false

# launch the player
func launch(direction: Vector2):
	print("Launched: (%d %d)" % [direction.x, direction.y])
	rolling = true;
	velocity += direction;

func _physics_process(delta: float):
	var input: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var mouse_vector: Vector2 = get_global_mouse_position()

	# all the movements
	if !rolling and !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		velocity = input * speed;
		jump_strength = 1.0
	elif !rolling and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		launch(Vector2(mouse_vector.x - position.x, mouse_vector.y - position.y).normalized() * launch_speed)
	else:
		velocity *= 0.9

	# deinitialization (DO NOT DO ANYTHING AFTER)
	if velocity.length() > 600:
		rolling = true
	else:
		rolling = false
	print(rolling)
	print(velocity.length())
	var collision = move_and_collide(velocity * delta)
	if collision and rolling:
		launch(collision.get_normal() * jump_strength * launch_speed)
		jump_strength -= 0.1
		var collider = collision.get_collider()
		if collider.is_in_group("Enemies") and rolling:
			collider.set("health", collider.get("health") - roll_damage)
			print(collider.get("health"))
