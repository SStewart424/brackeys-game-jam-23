extends Sprite2D

signal sonar_activated

var isOnCooldown: bool = false

@onready var _timer :Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
    _timer.timeout.connect(_reset_cooldown)
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if Input.is_action_pressed("sonar") && not isOnCooldown:
        isOnCooldown = true
        _timer.start()
        set_modulate(Color("6c6c6c"))
        sonar_activated.emit()

func _reset_cooldown():
    isOnCooldown = false
    set_modulate(Color("ffffff"))
