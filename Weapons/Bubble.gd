extends Area2D

var velocity = Vector2.ZERO
@export var speed = 400
const damage = 5

# Called when the node enters the scene tree for the first time.
func _ready():
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    position += velocity * delta

func set_velocity(new_velocity: Vector2):
    velocity = new_velocity.normalized() * speed

func _on_body_entered(body):
    if body.is_in_group("Enemy") && body.has_method("take_damage"):
        print("hit enemy")
        body.take_damage(damage)
        queue_free()
