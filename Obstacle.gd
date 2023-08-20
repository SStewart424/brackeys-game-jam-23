extends Area2D

@export var attack: int = 5

@onready var _animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    pass


func _on_body_entered(body):
    if body.is_in_group("Player"):
        body.take_damage(attack)
    hide()
    pass # Replace with function body.

func _on_sonar_sonar_activated():
    _animation.play("detected")
