extends CharacterBody2D

@export var max_speed: float = 300.0
@export var acceleration: float = 500.0
@export var friction: float = 100.0

var input: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	player_movement(delta)

func get_input() -> Vector2:
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return input.normalized()

func player_movement(delta: float) -> void:
	input = get_input()

	if input == Vector2.ZERO:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	else:
		velocity = velocity.move_toward(input * max_speed, acceleration * delta)

	move_and_slide()

