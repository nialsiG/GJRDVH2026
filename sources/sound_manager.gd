extends Node

@export var sound_queue: Array[AudioStreamPlayer]

@onready var ambiance_audio_stream_player: AudioStreamPlayer = %AmbianceAudioStreamPlayer

enum sound {
	CLICK,
	HOVER,
	TOWN_FESTIVE,
	TOWN_WARRIOR,
	TREE,
	SHEEP,
	WOLF,
	DOVE_NARRATOR,
	TREE_CUT,
	BROTHERS
}

enum ambiance {
	RIVER,
	NONE
}

const ARBRE_COUPE___HACHE_SUR_BOIS = preload("uid://owuego5vs7oj")
const CHOIX_FRERE_LAME_DE_COUTEAU = preload("uid://ysj3rn1lo7ji")
const CHOIX_FRÈRE_EPEE_QUI_COUPE = preload("uid://bffw0m7fu72xr")
const FORET = preload("uid://c8lueewj38xkl")
const RIVIÈRE_PETIT_TORRENT = preload("uid://bdabvj3qxskmv")
const UI_CLIC = preload("uid://roy3fmcn1s")
const UI_SURVOL = preload("uid://bi4mqlg0t5mag")
const SHEEP_STREAM_RANDOMIZER = preload("uid://bwbiv8deohfp3")
const WOLF_STREAM_RANDOMIZER = preload("uid://cdc6vraeaa4y6")
const BROTHERS_STREAM_RANDOMIZER = preload("uid://cqwth7feiswn3")
const VILLAGE_ALLIÉ_A_LAVINUM__FESTIF_ = preload("uid://fl3xx52a1dhx")
const VILLAGE_ALLIÉ_B_ARDEA__GUERRIER_ = preload("uid://d0asursq6glse")

var sound_volume: float = 0.3
var sound_queue_index: int = 0

func _ready():
	for child in sound_queue:
		child.volume_linear = sound_volume
	ambiance_audio_stream_player.volume_linear = sound_volume

func PlaySound(stream: sound):
	match stream:
		sound.CLICK:
			sound_queue[sound_queue_index].stream = UI_CLIC
		sound.HOVER:
			sound_queue[sound_queue_index].stream = UI_SURVOL
		sound.TOWN_FESTIVE:
			sound_queue[sound_queue_index].stream = VILLAGE_ALLIÉ_A_LAVINUM__FESTIF_
		sound.TOWN_WARRIOR:
			sound_queue[sound_queue_index].stream = VILLAGE_ALLIÉ_B_ARDEA__GUERRIER_
		sound.TREE:
			sound_queue[sound_queue_index].stream = FORET
		sound.SHEEP:
			sound_queue[sound_queue_index].stream = SHEEP_STREAM_RANDOMIZER
		sound.WOLF:
			sound_queue[sound_queue_index].stream = WOLF_STREAM_RANDOMIZER
		sound.DOVE_NARRATOR:
			sound_queue[sound_queue_index].stream = UI_CLIC
		sound.TREE_CUT:
			sound_queue[sound_queue_index].stream = ARBRE_COUPE___HACHE_SUR_BOIS
		sound.BROTHERS:
			sound_queue[sound_queue_index].stream = BROTHERS_STREAM_RANDOMIZER
	sound_queue[sound_queue_index].play()
	sound_queue_index = (sound_queue_index + 1) % sound_queue.size()


func PlayAmbiance(stream: ambiance):
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(ambiance_audio_stream_player,"volume_linear", 0.0, 0.5)
	match stream:
		ambiance.RIVER:
			ambiance_audio_stream_player.stream = RIVIÈRE_PETIT_TORRENT
		ambiance.NONE:
			ambiance_audio_stream_player.stop()
			return
	await tween.finished
	ambiance_audio_stream_player.play()
	tween = get_tree().create_tween()
	tween.tween_property(ambiance_audio_stream_player,"volume_linear", sound_volume, 0.5)
