extends CharacterBody2D


var bubble_scene = preload("res://Weapons/Bubble.tscn")
@export var fire_rate = 0.5  # Time in seconds between shots
@export var can_fire = true

@export var max_speed: float = 300.0
@export var acceleration: float = 500.0
@export var friction: float = 100.0

@export var health: int = 20

@onready var _animation = $AnimationPlayer


func _ready():
    _animation.play("idle")

func _physics_process(delta: float) -> void:
    player_movement(delta)
    player_shooting()

func get_input() -> Vector2:
    var input: Vector2 = Vector2.ZERO

    input.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
    input.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
    return input.normalized()


func player_shooting():
    if Input.is_action_pressed("fire") and can_fire:
        var cursor_pos = get_global_mouse_position()
        var player_pos = global_position
        var direction = (cursor_pos - player_pos).normalized()

        var bubble = bubble_scene.instantiate()
        bubble.position = player_pos
        get_parent().add_child(bubble)  # Add bullet to the main scene
        bubble.set_velocity(direction)
        can_fire = false
        $FireRateCooldownTimer.start(fire_rate)

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


    if health <= 0:
        hide()

    velocity = knockbackDirection.normalized() * knockbackForce
    move_and_slide()


func _on_fire_rate_cooldown_timer_timeout():
    can_fire = true
