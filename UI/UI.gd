extends CanvasLayer

var player

func _ready():
    player = get_node("../Player")

func _process(delta):
    update_depth_display()

func update_depth_display():
    if player:
        var depth = round(player.global_position.y / 100)
        $HBoxContainer/DepthCounterLabel.text = "Depth: " + str(depth)
