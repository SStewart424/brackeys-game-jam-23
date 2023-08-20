extends Area2D

@export var attack: int = 5
@export var knockback: float = 500.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Player"):
		var knockbackDirection = (body.global_position - global_position).normalized()
		body.take_damage(attack, knockbackDirection, knockback)
	queue_free()

