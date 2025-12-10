extends Label

func _process(_delta: float) -> void:
	self.text = str(roundi(Engine.get_frames_per_second())) + " FPS"
