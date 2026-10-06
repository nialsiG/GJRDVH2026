@tool
extends Control
class_name DialogueUI

enum State {
	Scrolling,
	Ended
}

@onready var panel: Panel = $Panel
@onready var label: RichTextLabel = %RichTextLabel
@onready var timer: Timer = $Timer
@onready var narrator_sprite_2d: TextureRect = %NarratorSprite2D
var current_state: State = State.Ended
@onready var animation_player: AnimationPlayer = %AnimationPlayer

@export var dialogue: Dialogue:
	set(new_value):
		dialogue = new_value

@export var show_venus_phases: Array[Phase]
@export var hide_venus_phases: Array[Phase]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.PhaseNewDialogue.connect(on_phase_new_dialogue)
	SignalManager.ShowVenus.connect(OnShowVenus)
	SignalManager.HideVenus.connect(OnHideVenus)
	GameManager.game_phase_changed.connect(OnNewPhase)

func on_phase_new_dialogue(new_dialogue: Dialogue) -> void:
	print_debug("on_phase_new_dialogue=", dialogue)
	dialogue = new_dialogue
	set_process_unhandled_input(true)
	_change_narrator_texture(dialogue.narrator_begin_texture)
	SoundManager.PlaySound(SoundManager.sound.DOVE_NARRATOR)
	_display_dialogue()
	_start_scrolling()

func OnNewPhase(phase: Phase):
	if show_venus_phases.has(phase):
		OnShowVenus()
	elif hide_venus_phases.has(phase):
		await SignalManager.PhaseEndChoiceDialogue
		OnHideVenus()

func OnShowVenus():
	animation_player.play("show_narrator")

func OnHideVenus():
	animation_player.play("hide_narrator")


func _display_dialogue() -> void:
	print("dialogue_ui: display dialogue")
	show()
	label.clear()
	label.append_text(tr(dialogue.loc_key))

func _change_narrator_texture(new_texture: Texture2D):
	if !narrator_sprite_2d:
		return
	narrator_sprite_2d.texture = new_texture
	narrator_sprite_2d.visible = new_texture != null

# --- Handle text defiling ----------------------------------------------------
func _on_defiling_timer_timeout() -> void:
	if label.visible_characters < label.get_parsed_text().length():
		label.visible_characters += 1
	else:
		_stop_scrolling()

func _start_scrolling() -> void:
	print_debug("started scrolling")
	current_state = State.Scrolling
	label.visible_characters = 0
	timer.start()
	_change_narrator_texture(dialogue.narrator_begin_texture)

func _stop_scrolling() -> void:
	print("stop scrolling")
	current_state = State.Ended
	label.visible_characters = -1
	timer.stop()
	_change_narrator_texture(dialogue.narrator_end_texture)

# --- When text is clicked ----------------------------------------------------
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if current_state == State.Scrolling:
			print("stop scrolling")
			_stop_scrolling()
		else:
			print("dialogue_ui: _unhandled_input else")
			set_process_unhandled_input(false)
			#hide()
			SignalManager.DialogueUIClickedOnDialogue.emit()
