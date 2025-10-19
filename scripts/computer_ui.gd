extends Control

@onready var label: Label = $Screen/Main/SignalIcon/Label
@onready var signal_manager: Control = $"Screen/Main/Signal Manager"
@onready var player: CharacterBody3D = $"../../"
@onready var file_viewer: Control = $"Screen/Main/File Viewer"
@onready var fv_label: Label = $Screen/Main/FileIcon/Label

var should_show_signal_dialog: bool = true
var should_show_fv_dialog: bool = true

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
	if event.is_action_pressed("interact") && not player.is_dialog_active:
		signal_manager.visible = !signal_manager.visible
		if should_show_signal_dialog:
			player.show_dialog("You", "Oh no... What is going on here???")
			should_show_signal_dialog = false

func _on_file_icon_mouse_entered() -> void:
	fv_label.label_settings.outline_size = 1


func _on_file_icon_mouse_exited() -> void:
	fv_label.label_settings.outline_size = 0


func _on_file_icon_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") && not player.is_dialog_active:
		file_viewer.visible = !file_viewer.visible
		if should_show_fv_dialog:
			player.show_dialog("You", "This looks quite interesting. It is decades old though...")
			should_show_fv_dialog = false
