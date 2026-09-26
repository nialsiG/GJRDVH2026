extends Node

@export var sound_queue: Array[AudioStreamPlayer]

@onready var ambiance_audio_stream_player: AudioStreamPlayer = %AmbianceAudioStreamPlayer

enum sound {
	CLICK,
	HOVER
}

enum ambiance {
	MAIN
}

const CLICK = preload("uid://d0bqbl8ql15hp")
const HOVER = preload("uid://doorb3jtlluwn")

const AMBIANCE_SANS_MUSIQUE_1 = preload("uid://cvmu4g4wajvgy")

var sound_volume: float = 1.0
var sound_queue_index: int = 0

func PlaySound(stream: sound):
	match stream:
		sound.CLICK:
			sound_queue[sound_queue_index].stream = CLICK
		sound.HOVER:
			sound_queue[sound_queue_index].stream = HOVER
	sound_queue[sound_queue_index].play()
	sound_queue_index = (sound_queue_index + 1) % sound_queue.size()
	print("sound_queue_index=", sound_queue_index, "/", sound_queue.size())


func PlayAmbiance(stream: ambiance):
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(ambiance_audio_stream_player,"volume_linear", 0.0, 0.5)
	match stream:
		ambiance.MAIN:
			ambiance_audio_stream_player.stream = AMBIANCE_SANS_MUSIQUE_1
	await tween.finished
	tween = get_tree().create_tween()
	tween.tween_property(ambiance_audio_stream_player,"volume_linear", sound_volume, 0.5)
