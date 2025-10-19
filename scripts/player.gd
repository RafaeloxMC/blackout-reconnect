extends CharacterBody3D

const SPEED = 100.0
const JUMP_VELOCITY = 100.0
const MOUSE_SENSITIVITY = 0.002

@onready var camera = $Camera3D
@onready var ray_cast_3d: RayCast3D = $Camera3D/RayCast3D
@onready var crosshair: Label = $GameUI/Crosshair

@onready var dialog: Control = $GameUI/Dialog
@onready var color_rect: ColorRect = $GameUI/Dialog/ColorRect
@onready var title: Label = $GameUI/Dialog/Title
@onready var text: Label = $GameUI/Dialog/Text


var rotation_x := 0.0
var rotation_y := 0.0

var current_collider = ""
var interactables = ["DeskCollider"]

func _ready() -> void:
	Engine.time_scale = 1
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	hide_dialog()

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotation_y -= event.relative.x * MOUSE_SENSITIVITY
		rotation_degrees.y = rad_to_deg(rotation_y)
		rotation_x = clamp(rotation_x - event.relative.y * MOUSE_SENSITIVITY, deg_to_rad(-90), deg_to_rad(90))
		camera.rotation.x = rotation_x
	elif event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta * 20

	if Input.is_action_just_pressed("dialog_next"):
		hide_dialog()

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	check_collisions()
	check_interactions()

	move_and_slide()

func check_collisions():
	if ray_cast_3d.is_colliding():
		current_collider = (ray_cast_3d.get_collider() as Node3D).name
		if interactables.has(current_collider):
			crosshair.label_settings.font_color.a = 1
		else:
			crosshair.label_settings.font_color.a = 100.0 / 255.0
	else:
		current_collider = ""

func check_interactions():
	if Input.is_action_just_pressed("interact"):
		if current_collider.contains("Desk"):
			show_dialog("You", "Phew, that was a lot of work yesterday... Let's check if everything's fine with the signal towers-")
			# SHOW DESK MENU

func hide_dialog():
	dialog.visible = false
	
func show_dialog(author: String, dialog_text: String):
	print("Showing dialog!")
	dialog.visible = true
	text.text = dialog_text
	title.text = author
