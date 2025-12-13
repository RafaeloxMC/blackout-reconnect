extends ColorRect

func _on_play_pressed() -> void:
	self.queue_free()

func _on_quit_pressed() -> void:
	SceneManager.call_scene("main_menu")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
