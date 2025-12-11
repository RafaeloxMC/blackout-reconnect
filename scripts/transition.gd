extends ColorRect

@export var speed_multiplier: float = 2

var height: float = -1.0
var shader_direction: bool = true # true = fwd; false = rev
var playing: bool = false

func _ready():
	rev()

func _process(delta: float) -> void:
	var mat = material
	if playing:
		if shader_direction:
			height = clamp(height + delta * speed_multiplier, -1.0, 1.0)
		else:
			height = clamp(height - delta * speed_multiplier, -1.0, 1.0)
		if mat is ShaderMaterial:
			mat.set_shader_parameter("height", height)
		else:
			print("NO MATERIAL")
		if abs(height) == 1:
			playing = false

func fwd() -> void:
	self.rotation_degrees = 180
	shader_direction = true
	height = -1
	playing = true
	
func rev() -> void:
	self.rotation_degrees = 0
	shader_direction = false
	height = 1
	playing = true
