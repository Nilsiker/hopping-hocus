extends Node2D

@onready var enemy = preload("res://scenes/enemy.tscn")
@onready var timer: Timer = $Timer

func clear_on_start():
	timer.wait_time = 2
	timer.start()


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.timeout.connect(spawn)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass   
	
func spawn():
	print(timer.wait_time)
	var enemy = enemy.instantiate()
	enemy.velocity = Vector2(-100, 0)
	enemy.global_position = global_position
	get_tree().current_scene.add_child(enemy)
	if timer.wait_time > 0.5:
		timer.wait_time -= 0.04
	enemy.add_to_group("clear_on_start")
	
