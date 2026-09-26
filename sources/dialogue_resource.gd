@tool
extends Resource
class_name DialogueResource

@export_category("Data")
@export var loc_key: String:
	set(new_setting):
		loc_key = new_setting
		changed.emit()

@export_category("Data")
@export var narrator_begin_texture: Texture2D:
	set(new_setting):
		narrator_begin_texture = new_setting
		changed.emit()

@export_category("Data")
@export var narrator_end_texture: Texture2D:
	set(new_setting):
		narrator_end_texture = new_setting
		changed.emit()

@export_category("Data")
@export var sound: AudioStream:
	set(new_setting):
		sound = new_setting
		changed.emit()