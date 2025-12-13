extends Resource
class_name FileContent

@export var title = "No Title Given"
@export var content = "No Content Given"

func _init(_title: String = "No Title Given", _content: String = "No Content Given"):
	title = _title
	content = _content
