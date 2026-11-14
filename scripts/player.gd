extends CharacterBody2D

@export var speed: float = 300.0;
@export var roll_limit: float = 600.0;
@export var launch_speed: float = 3000.0;

var rolling: bool = false;
var last_direction: Vector2 = Vector2.ZERO

# launch the player
func launch(direction: Vector2):
	print("Launched: (%d %d)" % [direction.x, direction.y])
	rolling = true;
	velocity += direction;

func _physics_process(delta: float):
	var input: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var mouse_vector: Vector2 = get_global_mouse_position()
	rolling = velocity.length() >= roll_limit
	
	# all the movements
	if !rolling and !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		velocity = input * speed;
	elif !rolling and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		launch(Vector2(mouse_vector.x - position.x, mouse_vector.y - position.y).normalized() * launch_speed)
	else:
		velocity *= 0.9
	
	# bouncing

	# deinitialization (DO NOT DO ANYTHING AFTER)
	last_direction = velocity;
	move_and_slide()
