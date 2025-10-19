extends Area3D

@export var author: String = "Anonymous voice"
@export var text: String = "This is some dialog"

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		body.show_dialog(author, text)
		self.queue_free()
