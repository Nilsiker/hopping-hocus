extends CharacterBody2D
class_name Hocus


const SPEED = 300.0
const JUMP_VELOCITY = -80.0

var health = 3
var flydust = 100

signal flydust_changed(new_value)
signal health_changed(new_value)
signal died;

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	flydust_changed.emit(flydust)
	health_changed.emit(health)

func initialize_on_game_start():
	health = 3
	flydust = 100
	$Spellcaster.clear_on_start()
	flydust_changed.emit(flydust)
	health_changed.emit(health)
	global_position = Vector2(-75,45)


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta * 0.5
		
	$AnimatedSprite2D.animation = "Walk" if is_on_floor() else "Fly"
	$Flydust.emitting = not is_on_floor()
		
	# Handle jump.
	if Input.is_action_pressed("ui_accept") :
		if Input.is_action_just_pressed("ui_accept"):
			flydust = max(flydust - 5, 0)
		if flydust:
			velocity.y = JUMP_VELOCITY
		flydust = max(flydust - 50 * delta, 0)
	else :
		flydust = min(flydust + 20 * delta, 100)

	flydust_changed.emit(flydust)

	move_and_slide()

func damage(number):
	health = max(0, health-number)
	health_changed.emit(health)
	if health == 0:
		died.emit()
	$AudioDamaged.pitch_scale = randf_range(1.0,1.5)		
	$AudioDamaged.play()
	$AnimatedSprite2D.modulate = Color.RED
	create_tween().tween_property($AnimatedSprite2D, "modulate", Color.WHITE, 0.5)
