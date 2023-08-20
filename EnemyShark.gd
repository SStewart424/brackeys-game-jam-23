extends CharacterBody2D

@export var max_speed: float = 50.0
@export var attack: float = 2.0
@export var knockback: float = 200.0
@export var acceleration: float = 300.0
@export var friction: float = 100.0

var target: Node2D

func _ready():
	target = get_node("../Player")  # Adjust the path to the character node

func _physics_process(delta: float) -> void:
	move_towards_target(delta)
	detect_collision()

func apply_knockback(direction: Vector2, force: float):
	velocity = direction.normalized() * force
	move_and_slide()

func detect_collision() -> void:
	var collision = get_last_slide_collision()
	if(collision != null):
		if(collision.get_collider().name == "Player"):
			var knockbackDirection = (target.global_position - global_position).normalized()
			var enemyKnockbackDirection = (global_position - target.global_position).normalized()
			apply_knockback(enemyKnockbackDirection, knockback)
			target.take_damage(attack, knockbackDirection, knockback)

func move_towards_target(delta: float) -> void:
	if target:
		var direction = (target.global_position - global_position).normalized()
		velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		
	move_and_slide()

