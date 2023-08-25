extends CanvasLayer

var score = 0  # Initialize the score

func _ready():
    pass

func update_score(new_score):
    score = new_score
    $VBoxContainer/ScoreLabel.text = "Score: " + str(score)

func _on_restart_button_pressed():
    get_tree().change_scene_to_file("res://Main.tscn")
    hide()
    get_tree().paused = false
