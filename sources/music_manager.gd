extends Node

@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer

const AMBIANCE_IDÉE_2 = preload("uid://bahq84yl8jwou")
const AMBIANCE_ECRAN_CHOIX = preload("uid://dk8fjgmkicsja")
const AMBIANCE_ECRAN_ENVIRO = preload("uid://dubvxqt31nx5d")
const AMBIANCE_FIN_RATEE = preload("uid://c60xwjr1cl3hj")
const AMBIANCE_FIN_REUSSIE = preload("uid://bfydbas1p373y")
const AMBIANCE_MENU = preload("uid://b0aihtuwuvje7")
const BONUS_AMBIANCE_TENSION = preload("uid://ci7mc4njkybvj")

enum music {
	DEFAULT,
	CHOIX,
	ENVIRONNEMENT,
	BAD_ENDING,
	GOOD_ENDING,
	MENU,
	BONUS_TENSION
}

var music_volume: float = 0.3

func _ready():
	PlayMusic(MusicManager.music.MENU)
	SignalManager.StopGame.connect(PlayMusic.bind(music.MENU))
	SignalManager.NewGame.connect(PlayMusic.bind(music.ENVIRONNEMENT))

func PlayMusic(stream: music):
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(audio_stream_player,"volume_linear", 0.0, 0.5)
	await tween.finished
	match stream:
		music.DEFAULT:
			audio_stream_player.stream = AMBIANCE_IDÉE_2
		music.CHOIX:
			audio_stream_player.stream = AMBIANCE_ECRAN_CHOIX
		music.ENVIRONNEMENT:
			audio_stream_player.stream = AMBIANCE_ECRAN_ENVIRO
		music.BAD_ENDING:
			audio_stream_player.stream = AMBIANCE_FIN_RATEE
		music.GOOD_ENDING:
			audio_stream_player.stream = AMBIANCE_FIN_REUSSIE
		music.MENU:
			audio_stream_player.stream = AMBIANCE_MENU
		music.BONUS_TENSION:
			audio_stream_player.stream = BONUS_AMBIANCE_TENSION
	audio_stream_player.play()
	tween = get_tree().create_tween()
	tween.tween_property(audio_stream_player,"volume_linear", music_volume, 0.5)
