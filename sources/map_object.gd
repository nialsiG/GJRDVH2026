@tool
extends Node2D
class_name MapObject

@export var map_object_resource: MapObjectResource:
	set(new_resource):
		# Disconnect the signal if the previous resource was not null.
		if map_object_resource != null and map_object_resource.changed.has_connections():
			map_object_resource.changed.disconnect(OnResourceChange)
		map_object_resource = new_resource
		OnResourceChange()
		if map_object_resource != null:
			map_object_resource.changed.connect(OnResourceChange)

@export var interactable: Interactable
@onready var sprite_2d: Sprite2D = %Sprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = %AudioStreamPlayer2D
@onready var tooltip_label: Label = %TooltipLabel

var hide_after_choice: bool = false;

const OUTLINE_SHADER_MATERIAL = preload("uid://desy0lgw0pa8s")

func _ready():
	print("map_object: ready")
	SignalManager.NewGame.connect(Reset)
	GameManager.game_phase_changed.connect(on_game_phase_changed)
	SignalManager.PhaseEndChoiceDialogue.connect(on_phase_end_choice_dialogue)
	SignalManager.ChoiceIsMade.connect(on_choice_is_made)
	if interactable:
		interactable.clicked.connect(on_map_object_clicked)
		interactable.mouse_entered.connect(on_map_object_hovered)
		interactable.mouse_exited.connect(on_map_object_exited)

func Reset():
	hide_after_choice = false
	hide()
	if !map_object_resource:
		return
	if map_object_resource.default_visible:
		show()
	ChangeTexture(map_object_resource.texture)
	if !audio_stream_player_2d.stream:
		audio_stream_player_2d.stop()
	tooltip_label.hide()

func OnResourceChange():
	if !sprite_2d || !map_object_resource:
		return
	sprite_2d.texture = map_object_resource.texture

func on_game_phase_changed(phase: Phase):
	print("map_object: on_game_phase_changed")
	if !map_object_resource:
		printerr("map_object_resource is null")
		return
	if !phase:
		printerr("phase is null")
		return

	if map_object_resource.visible_on_phases.size() > 0:
		if map_object_resource.visible_on_phases.has(phase.stage) and !visible and !hide_after_choice:
			Show()
		elif !map_object_resource.visible_on_phases.has(phase.stage) and visible:
			Hide()

func on_phase_end_choice_dialogue(phase: Phase):
	print_debug("map_object: on_phase_end_choice_dialogue [stage= ", phase.stage, "] [state= ", phase.state, "]")
	if phase && map_object_resource.interactable_on_phase_stage && map_object_resource.interactable_on_phase_stage == phase.stage:
		Activate()

func Activate():
	print("map_object: activate")
	if interactable:
		interactable.collision_shape_2d.disabled = false

func Deactivate():
	print("map_object: deactivate")
	if interactable:
		interactable.collision_shape_2d.disabled = true

func Show():
	print("map_object: show")
	sprite_2d.modulate = Color.TRANSPARENT
	show()
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "modulate", Color.WHITE, 0.5)
	if audio_stream_player_2d.stream:
		audio_stream_player_2d.play()

func Hide():
	print("map_object: hide")
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "modulate", Color.TRANSPARENT, 0.5)
	tween.tween_callback(hide)
	if audio_stream_player_2d.stream:
		audio_stream_player_2d.stop()

func ChangeTexture(new_texture: Texture2D):
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "modulate", Color.TRANSPARENT, 0.5)
	await tween.finished
	sprite_2d.texture = new_texture
	tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "modulate", Color.WHITE, 0.5)


func on_map_object_hovered():
	print("HOVERED")
	MouseManager.ChangeCursor(MouseManager.CURSOR2)
	sprite_2d.material = OUTLINE_SHADER_MATERIAL
	if map_object_resource.sound_effect:
		SoundManager.PlaySound(map_object_resource.sound_effect)
	else:
		SoundManager.PlaySound(SoundManager.sound.CLICK)
	tooltip_label.text = map_object_resource.tooltip_text
	tooltip_label.show()
	

func on_map_object_exited():
	MouseManager.ChangeCursor(MouseManager.CURSOR1)
	sprite_2d.material = null
	tooltip_label.hide()

func on_map_object_clicked():
	print("on_map_object_clicked")
	Deactivate()
	KarmaManager.add_choice(map_object_resource.choice_to_add)
	# Changes on click
	if map_object_resource.new_texture:
		ChangeTexture(map_object_resource.new_texture)
	if map_object_resource.sound_effect:
		SoundManager.PlaySound(map_object_resource.sound_effect)
	else:
		SoundManager.PlaySound(SoundManager.sound.CLICK)
	#if map_object_resource.ambiance_sound != SoundManager.ambiance.NONE:
		#SoundManager.PlayAmbiance(map_object_resource.ambiance_sound)
	KarmaManager.add_wise_points(map_object_resource.wise_points)
	KarmaManager.add_evil_points(map_object_resource.evil_points)

func on_choice_is_made(choice: EnumCollection.EChoice):
	if choice == EnumCollection.EChoice.RIVER and map_object_resource.is_map_with_river:
		Show()
		#SoundManager.PlayAmbiance(SoundManager.ambiance.RIVER)
	if map_object_resource.remove_if_choice_is_made == choice:
		hide_after_choice = true
		Hide()
