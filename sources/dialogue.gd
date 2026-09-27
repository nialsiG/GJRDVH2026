@tool
extends Control
class_name Dialogue

enum State {
	Defiling,
	Ended
}

@onready var panel: Panel = $Panel
@onready var label: RichTextLabel = %RichTextLabel
@onready var timer: Timer = $Timer
@onready var narrator_sprite_2d: Sprite2D = $Panel/NarratorSprite2D
var current_state: State = State.Ended

@export var dialogue_res: DialogueResource:
	set(new_resource):
		if dialogue_res != null and dialogue_res.changed.has_connections():
			dialogue_res.changed.disconnect(_OnResourceChanged)
		dialogue_res = new_resource
		_OnResourceChanged()
		if dialogue_res != null:
			dialogue_res.changed.connect(_OnResourceChanged)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TranslationServer.set_locale("french")
	panel.visible = false
	narrator_sprite_2d.visible = false
	SignalManager.DialogueStarted.connect(_OnDialogueStarted)
	SignalManager.DialogueEnded.connect(_OnDialogueEnded)
	SignalManager.NextDialogue.connect(_OnNextDialogue)

# --- OnDialogue handlers -----------------------------------------------------
func _OnDialogueStarted():
	panel.visible = true
	dialogue_res = DialogueManager.curr_dialogue_res
	print("Dialogue: _OnDialogueStarted")

func _OnDialogueEnded():
	panel.visible = false
	print("Dialogue: _OnDialogueEnded")
	
func _OnNextDialogue():
	dialogue_res = DialogueManager.curr_dialogue_res
	SoundManager.PlaySound(SoundManager.sound.DOVE_NARRATOR)


# --- Handle text defiling ----------------------------------------------------
func _on_defiling_timer_timeout() -> void:
	if label.visible_characters < label.get_parsed_text().length():
		label.visible_characters += 1
	else:
		_StopDefiling()

func _StartDefiling():
	print("Started defiling")
	current_state = State.Defiling
	label.visible_characters = 0
	timer.start()
	_ChangeNarratorTexture(dialogue_res.narrator_begin_texture)

func _StopDefiling():
	current_state = State.Ended
	label.visible_characters = -1
	timer.stop()
	_ChangeNarratorTexture(dialogue_res.narrator_end_texture)

# --- When text is clicked ----------------------------------------------------
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if current_state == State.Defiling:
			_StopDefiling()
		else:
			SignalManager.PlayerClickedOnDialogue.emit()


# --- Helpers -----------------------------------------------------------------
func _ChangeNarratorTexture(new_texture: Texture2D):
	narrator_sprite_2d.texture = new_texture
	narrator_sprite_2d.visible = new_texture != null

# When dialogue_res is set
func _OnResourceChanged():
	if !label:
		return
	label.clear()
	var loc_str = tr(dialogue_res.loc_key)
	label.append_text(loc_str)
	_StartDefiling()
