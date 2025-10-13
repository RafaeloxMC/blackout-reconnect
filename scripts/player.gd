extends CharacterBody3D

const SPEED = 100.0
const JUMP_VELOCITY = 100.0
const MOUSE_SENSITIVITY = 0.002  # Adjust to your liking

@onready var camera = $Camera3D  # Make sure you have a Camera3D as a child

var rotation_x := 0.0  # Pitch (camera up/down)
var rotation_y := 0.0  # Yaw (character left/right)

func _ready() -> void:
	Engine.time_scale = 1
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # Lock and hide the mouse

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		# Rotate character horizontally
		rotation_y -= event.relative.x * MOUSE_SENSITIVITY
		rotation_degrees.y = rad_to_deg(rotation_y)

		# Rotate camera vertically (limit pitch)
		rotation_x = clamp(rotation_x - event.relative.y * MOUSE_SENSITIVITY, deg_to_rad(-90), deg_to_rad(90))
		camera.rotation.x = rotation_x

	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)  # Unlock mouse when pressing ESC

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity += get_gravity() * delta * 20

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movement input
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
