extends Control

@onready var password_field: LineEdit = $"Background/Right/Password Field"
@onready var status: Label = $Background/Right/Status
@onready var button: Button = $Background/Right/Button
@onready var lost: Label = $Background/Left/LOST

var mouse_inside: bool = false
var mouse_offset: Vector2 = Vector2(0, 0)
var dragging: bool = false

func _process(_delta: float) -> void:
	if dragging:
		var new_pos = get_global_mouse_position() - mouse_offset
		
		var parent = get_parent()
		var parent_rect = parent.get_global_rect() if parent else get_viewport_rect()
		
		var own_rect = get_global_rect()
		
		new_pos.x = clamp(new_pos.x, parent_rect.position.x, parent_rect.end.x - own_rect.size.x)
		new_pos.y = clamp(new_pos.y, parent_rect.position.y, parent_rect.end.y - own_rect.size.y)
		
		global_position = new_pos

func _on_navbar_mouse_entered() -> void:
	mouse_inside = true

func _on_navbar_mouse_exited() -> void:
	mouse_inside = false

func _on_navbar_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and mouse_inside:
				mouse_offset = get_global_mouse_position() - global_position
				dragging = true
			elif not event.pressed:
				dragging = false
		if event.button_index == MOUSE_BUTTON_RIGHT:
			dragging = false


func _on_button_pressed() -> void:
	if password_field.text == "8271":
		button.disabled = true
		status.text = "DECODING..."
		await get_tree().create_timer(1).timeout
		status.text = "AWAITING DATA..."
		await get_tree().create_timer(1).timeout
		status.text = "FOUND DATA!"
		await get_tree().create_timer(1).timeout
		status.text = "SENDING PAYlOAD TO SIGNAL TOWERS..."
		await get_tree().create_timer(3).timeout
		status.text = "SENT!"
		lost.text = "Connected"
		lost.label_settings.font_color = Color(0.0, 0.564, 0.0, 1.0)
	else:
		status.text = "Wrong password!"
