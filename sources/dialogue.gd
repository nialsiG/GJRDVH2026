@tool
extends Control
class_name Dialogue

enum State {
	Defiling,
	Ended
}

@onready var panel: Panel = $Panel
@onready var label: RichTextLabel = $Panel/MarginContainer/RichTextLabel
@onready var timer: Timer = $Timer
@onready var narrator_sprite_2d: Sprite2D = $Panel/NarratorSprite2D
var current_state: State = State.Ended

@export var dialogue_res: DialogueResource:
	set(new_resource):
		if dialogue_res != null and dialogue_res.changed.has_connections():
			dialogue_res.changed.disconnect(OnResourceChange)
		dialogue_res = new_resource
		OnResourceChange()
		if dialogue_res != null:
			dialogue_res.changed.connect(OnResourceChange)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	panel.visible = false
	narrator_sprite_2d.visible = false
	SignalManager.DialogueStarted.connect(OnStarted)
	SignalManager.DialogueEnded.connect(OnEnded)
	SignalManager.NextDialogue.connect(OnNextDialogue)

func OnStarted():
	panel.visible = true
	dialogue_res = DialogueManager.curr_dialogue_res
	print("Dialogue: OnStarted")

func OnEnded():
	panel.visible = false
	print("Dialogue: OnEnded")
	
func OnNextDialogue():
	dialogue_res = DialogueManager.curr_dialogue_res

func OnResourceChange():
	if !label:
		return
	label.clear()
	var loc_str = tr(dialogue_res.loc_key)
	label.append_text(loc_str)
	StartDefiling()

func _on_defiling_timer_timeout() -> void:
	if label.visible_characters < label.get_parsed_text().length():
		label.visible_characters += 1
	else:
		StopDefiling()

func StartDefiling():
	print("Started defiling")
	current_state = State.Defiling
	label.visible_characters = 0
	timer.start()
	_change_narrator_texture(dialogue_res.narrator_begin_texture)

func StopDefiling():
	current_state = State.Ended
	label.visible_characters = -1
	timer.stop()
	_change_narrator_texture(dialogue_res.narrator_end_texture)

func _on_rich_text_label_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if current_state == State.Defiling:
			StopDefiling()
		else:
			SignalManager.PlayerClickedOnDialogue.emit()

func _change_narrator_texture(new_texture: Texture2D):
	if new_texture:
		narrator_sprite_2d.texture = new_texture
		narrator_sprite_2d.visible = true
	else:
		narrator_sprite_2d.texture = null
		narrator_sprite_2d.visible = false
