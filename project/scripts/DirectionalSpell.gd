extends Area2D

@export var velocity: Vector2
@export var destroy_on_hit: bool
@export var explosion = preload("res://scenes/fireball_explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_body_entered)
	if not destroy_on_hit:
		var tween = create_tween()
		tween.tween_property(self, "modulate", Color(1,1,1,0), 1)
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_callback(func(): queue_free())
		create_tween().tween_property($AudioCrackling, "volume_db", -18,  1)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += velocity * delta

func _on_body_entered(body: Node2D):
	if body is Hocus: return
	
	if body is Enemy:
		body.die()
	if destroy_on_hit:
		var boom = explosion.instantiate() 
		boom.global_position = global_position
		get_tree().current_scene.add_child(boom)
		queue_free()
		
