extends Control

@onready var v_sync: Button = $UIElements/VSync

func _ready() -> void:
	v_sync.text = "VSync: On" if DisplayServer.window_get_vsync_mode() == DisplayServer.VSyncMode.VSYNC_ENABLED else "VSync: Off"

func _on_play_pressed() -> void:
	SceneManager.call_scene("game")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_v_sync_pressed() -> void:
	if DisplayServer.window_get_vsync_mode() == DisplayServer.VSyncMode.VSYNC_ENABLED:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		v_sync.text = "VSync: Off"
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		v_sync.text = "VSync: On"
