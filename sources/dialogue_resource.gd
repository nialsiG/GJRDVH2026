@tool
extends Resource
class_name DialogueResource

@export_category("Data")
@export var loc_key: String:
	set(new_setting):
		loc_key = new_setting
		changed.emit()
