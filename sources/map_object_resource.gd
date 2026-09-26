@tool
extends Resource
class_name MapObjectResource

@export_category("Art")
@export var texture: Texture2D:
	set(new_setting):
		texture = new_setting
		changed.emit()
