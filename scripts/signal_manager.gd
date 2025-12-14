extends Control

@onready var password_field: LineEdit = $"Background/Right/Password Field"
@onready var status: Label = $Background/Right/Status
@onready var button: Button = $Background/Right/Button
@onready var lost: Label = $Background/Left/LOST
@onready var typing_sound: AudioStreamPlayer = $TypingSound
@onready var success_sound: AudioStreamPlayer = $SuccessSound
@onready var fail_sound: AudioStreamPlayer = $FailSound
@onready var last_ping: Label = $"Background/Left/Last Ping"

var mouse_inside: bool = false
var mouse_offset: Vector2 = Vector2.ZERO
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

func type_text(text: String, delay: float = 0.04) -> void:
	status.text = ""
	for c in text:
		status.text += c
		if typing_sound:
			typing_sound.play()
		await get_tree().create_timer(delay).timeout

func loading_text(text: String, duration: float) -> void:
	var time: float = 0.0
	while time < duration:
		status.text = text + ".".repeat(int(time * 4) % 4)
		if typing_sound:
			typing_sound.play()
		await get_tree().create_timer(0.3).timeout
		time += 0.3

func win_animation() -> void:
	status.modulate.a = 0.0
	status.scale = Vector2(0.9, 0.9)
	var tween: Tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_property(status, "modulate:a", 1.0, 0.6)
	tween.tween_property(status, "scale", Vector2.ONE, 0.6)

func win_sequence() -> void:
	button.disabled = true

	await loading_text("DECODING", 1.2)
	await loading_text("AWAITING DATA", 1.2)

	await type_text("FOUND DATA!")
	await get_tree().create_timer(0.8).timeout

	await type_text("SENDING PAYLOAD TO SIGNAL TOWERS")
	await loading_text("", 2.0)

	status.text = "SENT!"
	if success_sound:
		success_sound.play()
		
	last_ping.text = "Last ping: now"

	lost.text = "CONNECTED"
	lost.label_settings.font_color = Color(0.0, 0.564, 0.0, 1.0)
	lost.scale = Vector2(1.2, 1.2)

	var tween: Tween = create_tween()
	tween.tween_property(lost, "modulate:a", 1.0, 0.4)
	tween.tween_property(lost, "scale", Vector2.ONE, 0.4)

	await get_tree().create_timer(1.0).timeout

	status.text = "YOU WON!"
	win_animation()

func _on_button_pressed() -> void:
	if password_field.text == "8247":
		await win_sequence()
	else:
		if fail_sound:
			fail_sound.play(0.3)
		await type_text("WRONG PASSWORD")

func _on_close_nav_pressed() -> void:
	hide()
