extends Control

@export var velocity: Vector2
@export var start_pos = Vector2(126, -63)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for child in get_children():
		var bg: TextureRect = child
		bg.global_position += velocity * delta
		print(bg.name, bg.global_position)
		if bg.global_position.x < -386:
			bg.global_position = start_pos
