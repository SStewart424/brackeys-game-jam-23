extends Area2D

@export var speed = 400
const direction = Vector2.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    position += direction * speed * delta
    if position.x > 2000:
        queue_free()
