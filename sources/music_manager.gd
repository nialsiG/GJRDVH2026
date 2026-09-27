extends Node

@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer

const AMBIANCE_IDÉE_2 = preload("uid://bahq84yl8jwou")

enum music {
	MAIN
}

var music_volume: float = 0.3

func _ready():
	PlayMusic(MusicManager.music.MAIN)


func PlayMusic(stream: music):
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(audio_stream_player,"volume_linear", 0.0, 0.5)
	await tween.finished
	match stream:
		music.MAIN:
			audio_stream_player.stream = AMBIANCE_IDÉE_2
	audio_stream_player.play()
	tween = get_tree().create_tween()
	tween.tween_property(audio_stream_player,"volume_linear", music_volume, 0.5)
