extends Control

@onready var label: Label = $Screen/Main/SignalIcon/Label
@onready var signal_manager: Control = $"Screen/Main/Signal Manager"


func opened() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	print("Opened computer")
	pass

func _on_visibility_changed() -> void:
	if self.visible == true:
		opened()


func _on_signal_icon_mouse_entered() -> void:
	label.label_settings.outline_size = 1


func _on_signal_icon_mouse_exited() -> void:
	label.label_settings.outline_size = 0


func _on_signal_icon_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		signal_manager.visible = !signal_manager.visible
