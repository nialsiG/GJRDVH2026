@tool
extends Resource
class_name MapObjectResource

@export_category("Data")
@export var texture: Texture2D:
	set(new_setting):
		texture = new_setting
		changed.emit()

@export_category("On Click")
@export var new_texture: Texture2D:
	set(new_setting):
		new_texture = new_setting
		changed.emit()
