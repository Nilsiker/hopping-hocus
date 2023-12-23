extends Node

@export var audio: AudioStreamPlayer2D

func _ready():
	audio.finished.connect(destroy)
	print("boom")


func destroy():
	get_parent().queue_free()
	
	

