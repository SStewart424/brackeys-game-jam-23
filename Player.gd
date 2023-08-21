extends CharacterBody2D

@export var max_speed: float = 300.0
@export var acceleration: float = 500.0
@export var friction: float = 100.0

@export var health: int = 20

@onready var _animation = $AnimationPlayer

signal missile_fire


func _ready():
    _animation.play("idle")

func _physics_process(delta: float) -> void:
    player_movement(delta)

func get_input() -> Vector2:
    var input: Vector2 = Vector2.ZERO
    
    input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
    input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
    
    if Input.is_action_just_pressed("fire"):
        missile_fire.emit(position)
        
    return input.normalized()


func player_movement(delta: float) -> void:
    var input: Vector2 = get_input()

    if input == Vector2.ZERO:
        velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
    else:
        velocity = velocity.move_toward(input * max_speed, acceleration * delta)

    move_and_slide()

func take_damage(amount: int, knockbackDirection: Vector2 = Vector2.ZERO, knockbackForce: float = 0.0):
    print("took damage")
    health -= amount
    _animation.play("hurt")
    _animation.queue("idle")
    
    
    if health == 0:
        hide()
    
    velocity = knockbackDirection.normalized() * knockbackForce
    move_and_slide()
