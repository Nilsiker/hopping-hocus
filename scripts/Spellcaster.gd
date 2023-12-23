extends Node2D

var fireball: PackedScene = preload("res://scenes/fireball.tscn")
var glacier: PackedScene = preload("res://scenes/glacier.tscn")
var charges = 4

@onready var timer = $Timer

signal charges_changed(number)

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.timeout.connect(func(): 
		charges = min(charges+1, 4)
		charges_changed.emit(charges)
	)
	
	pass # Replace with function body.

func clear_on_start():
	charges = 4
	charges_changed.emit(4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _unhandled_input(event):
	if charges > 0 and event.is_action_pressed("fireball"):
		charges -= 1
		charges_changed.emit(charges)
		var ball = fireball.instantiate()
		ball.global_position = global_position
		get_tree().current_scene.add_child(ball)
		if timer.is_stopped():
			timer.start()
		ball.add_to_group("clear_on_start")
		
	if charges > 0 and event.is_action_pressed("glacier"):
		charges -= 1
		charges_changed.emit(charges)
		var spell = glacier.instantiate()
		spell.global_position = global_position
		get_tree().current_scene.add_child(spell)
		if timer.is_stopped():
			timer.start()
		spell.add_to_group("clear_on_start")
		

		
