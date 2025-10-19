extends Control

@onready var label: Label = $SignalIcon/Label

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
