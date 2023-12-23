extends CanvasLayer

var game = preload("res://scenes/main.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$PanelContainer/MarginContainer/VBoxContainer/Play.pressed.connect(func(): get_tree().change_scene_to_packed(game))
	$PanelContainer/MarginContainer/VBoxContainer/Quit.pressed.connect(func(): get_tree().quit())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
