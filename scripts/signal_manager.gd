extends Control

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
	print("MOUSE ENTERED NAVBAR")

func _on_navbar_mouse_exited() -> void:
	mouse_inside = false
	print("MOUSE EXITED NAVBAR")

func _on_navbar_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		print("MOUSE BTN EVENT FIRED")
		if event.button_index == MOUSE_BUTTON_LEFT:
			print("EVENT IS BTN LEFT")
			if event.pressed and mouse_inside:
				print("PRESSED AND INSIDE")
				mouse_offset = get_global_mouse_position() - global_position
				dragging = true
			elif not event.pressed:
				print("NOT PRESSED")
				dragging = false
		if event.button_index == MOUSE_BUTTON_RIGHT:
			print("MOUSE BTN RIGHT")
			dragging = false
