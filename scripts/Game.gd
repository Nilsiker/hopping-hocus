extends Node2D
class_name Game

@export var score_label: Label
@export var high_score_label: Label

var score = 0
var high_score: int

var game_over = false


signal score_updated(new_score)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.timeout.connect(func(): increase_score(1))
	if FileAccess.file_exists("user://high_score.save"):
		high_score = FileAccess.open("user://high_score.save", FileAccess.READ).get_line() as int
	else: high_score = 0
	
	high_score_label.update_text(str(high_score))
	$CanvasLayer/GameOver/VBoxContainer/Buttons/PlayAgain.pressed.connect(start_game)
	$CanvasLayer/GameOver/VBoxContainer/Buttons/Quit.pressed.connect(func(): get_tree().quit())
	$CanvasLayer/Pause/Quit.pressed.connect(func(): get_tree().quit())

func increase_score(value):
	score += value
	score_updated.emit(score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	score * delta

func start_game():
	score = 0
	score_updated.emit(score)
	$Spawner.clear_on_start()
	get_tree().call_group("clear_on_start", "queue_free")
	$Hocus.initialize_on_game_start()
	Engine.time_scale = 1
	$CanvasLayer/GameOver.visible = false
	$CanvasLayer/MarginContainer.visible = true
	if FileAccess.file_exists("user://high_score.save"):
		high_score = FileAccess.open("user://high_score.save", FileAccess.READ).get_line() as int
	else: high_score = 0
	high_score_label.update_text(str(high_score))


func _input(event):
	if game_over: return
	
	if event.is_action_pressed("ui_cancel"):
		if Engine.time_scale < 1:
			Engine.time_scale = 1
			$CanvasLayer/Pause.visible=false
			$CanvasLayer/MarginContainer.visible = true
			score_label.visible = true
			
		else:
			Engine.time_scale = 0
			$CanvasLayer/Pause.visible=true	
			$CanvasLayer/MarginContainer.visible = false
			score_label.visible = false

func _on_hocus_died():
	$CanvasLayer/GameOver.visible = true
	$CanvasLayer/MarginContainer.visible = false
	$CanvasLayer/GameOver/VBoxContainer/HBoxContainer/Score.text = str(score)
	Engine.time_scale = 0
	if score > high_score:
		$CanvasLayer/GameOver/VBoxContainer/HighScore.visible = true
		var save = FileAccess.open("user://high_score.save", FileAccess.WRITE)
		save.store_line(str(score))
