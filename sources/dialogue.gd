@tool
extends Resource
class_name Dialogue

@export var default_loc_key: String:
	set(new_value):
		default_loc_key = new_value
		changed.emit()

@export var default_narrator_begin_texture: Texture2D:
	set(new_value):
		default_narrator_begin_texture = new_value
		changed.emit()

@export var default_narrator_end_texture: Texture2D:
	set(new_value):
		default_narrator_end_texture = new_value
		changed.emit()

@export var default_sound: AudioStream:
	set(new_value):
		default_sound = new_value
		changed.emit()

var _loc_key: String
var _narrator_begin_texture: Texture2D
var _narrator_end_texture: Texture2D
var _sound: AudioStream

func default() -> Dialogue:
	_loc_key = ""
	_narrator_begin_texture = Texture2D.new()
	_narrator_end_texture = Texture2D.new()
	_sound = AudioStream.new()
	return self
