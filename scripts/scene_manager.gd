extends Node

@export var scenes: Dictionary[String, PackedScene]
@onready var transition: ColorRect = $Transition

@export var scene_history: Array[PackedScene] = []

func call_packed(scene: PackedScene) -> void:
	transition.fwd()
	await get_tree().create_timer(2 / transition.speed_multiplier).timeout
	get_tree().change_scene_to_packed(scene)
	scene_history.append(scene)
	transition.rev()

func call_scene(scene: String) -> void:
	if scenes.get(scene):
		call_packed(scenes.get(scene))

func back():
	call_packed(scene_history[scene_history.size() - 2])
