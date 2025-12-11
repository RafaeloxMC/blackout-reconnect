extends Control

func _on_play_pressed() -> void:
	SceneManager.call_scene("game")


func _on_quit_pressed() -> void:
	get_tree().quit()
