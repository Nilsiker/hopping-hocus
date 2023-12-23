extends Area2D
class_name Enemy

@export var velocity:Vector2
@onready var timer: Timer = $Timer
@export var in_air: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(on_body_entered)
	timer.wait_time = randf_range(0,3) 
	timer.timeout.connect(jump)
	timer.start()
	$AnimatedSprite2D.animation = "Idle"
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += velocity*delta
	if in_air:
		velocity += Vector2(0, 980/2* delta)
	
func on_body_entered(body:Node2D):
	if body is Hocus:
		body.damage(1)

func jump():
	if not in_air:
		velocity = velocity + (Vector2.UP * 150) + (Vector2.LEFT * 80  )
		$AnimatedSprite2D.animation = "Jump"
		in_air = true
		

func die():
	get_tree().current_scene.increase_score(10)
	queue_free()
