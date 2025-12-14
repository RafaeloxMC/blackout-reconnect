extends Control

@onready var button: Button = $Butto


func _on_button_pressed() -> void:
	SceneManager.call_scene("main_menu")
