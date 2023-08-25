extends Node2D

var enemyScene = preload("res://Units/EnemyShark.tscn")

var spawn_interval = 3

func _ready():
    $EnemySpawnTimer.set_wait_time(spawn_interval)
    $EnemySpawnTimer.start()

func spawn_enemy():
    var player_pos = $Player.global_position
    var spawn_radius = 400
    var angle = randf_range(0, 360)

    # Convert angle to radians
    var radians = deg_to_rad(angle)

    # Calculate spawn position
    var spawn_x = player_pos.x + spawn_radius * cos(radians)
    var spawn_y = player_pos.y + spawn_radius * sin(radians)

    var enemy = enemyScene.instantiate()
    add_child(enemy)
    enemy.global_position = Vector2(spawn_x, spawn_y)

func _on_enemy_spawn_timer_timeout():
    print("spawner timedout")
    spawn_enemy()
