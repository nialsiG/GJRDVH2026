@tool
extends Resource
class_name Dialogue

@export var loc_key: String:
	set(new_value):
		loc_key = new_value
		changed.emit()

@export var narrator_begin_texture: Texture2D = preload("uid://r24goacbox5c"):
	set(new_value):
		narrator_begin_texture = new_value
		changed.emit()

@export var narrator_end_texture: Texture2D = preload("uid://b7cg8wa6j0q8m"):
	set(new_value):
		narrator_end_texture = new_value
		changed.emit()

@export var sound: AudioStream:
	set(new_value):
		sound = new_value
		changed.emit()