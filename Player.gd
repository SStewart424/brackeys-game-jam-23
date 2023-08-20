extends CharacterBody2D

@export var max_speed: float = 300.0
@export var acceleration: float = 500.0
@export var friction: float = 100.0

@onready var _animated_sprite = $AnimationPlayer



func _ready():
    _animated_sprite.play("idle")

func _physics_process(delta: float) -> void:
    player_movement(delta)

func get_input() -> Vector2:
    var input: Vector2 = Vector2.ZERO
    
    input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
    input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
    return input.normalized()


func player_movement(delta: float) -> void:
    var input: Vector2 = get_input()

    if input == Vector2.ZERO:
        velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
    else:
        velocity = velocity.move_toward(input * max_speed, acceleration * delta)

    move_and_slide()

