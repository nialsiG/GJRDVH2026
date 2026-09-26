@tool
extends Control
class_name Dialogue

enum State {
	Defiling,
	Ended
}

@onready var panel: Panel = $Panel
@onready var label: RichTextLabel = $Panel/RichTextLabel
@onready var timer: Timer = $Timer
var current_state: State = State.Defiling

@export var dialogue_resource: DialogueResource:
	set(new_resource):
		if dialogue_resource != null and dialogue_resource.changed.has_connections():
			dialogue_resource.changed.disconnect(OnResourceChange)
		dialogue_resource = new_resource
		OnResourceChange()
		if dialogue_resource != null:
			dialogue_resource.changed.connect(OnResourceChange)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	panel.visible = false
	SignalManager.DialogueStarted.connect(OnStarted)
	SignalManager.DialogueEnded.connect(OnEnded)
	SignalManager.NextDialogue.connect(OnNextDialogue)

func OnStarted():
	panel.visible = true
	print("Dialogue: OnStarted")

func OnEnded():
	panel.visible = false
	print("Dialogue: OnEnded")
	

func OnNextDialogue():
	dialogue_resource = DialogueManager.curr_dialogue_resource
	print("Dialogue: OnNextDialogue")

func OnResourceChange():
	if !label or !dialogue_resource:
		return
	label.clear()
	var loc_str = tr(dialogue_resource.loc_key)
	label.append_text(loc_str)
	StartDefiling()

func _on_defiling_timer_timeout() -> void:
	if label.visible_characters < label.get_parsed_text().length():
		label.visible_characters += 1
	else:
		StopDefiling()

func StartDefiling():
	current_state = State.Defiling
	label.visible_characters = 0
	timer.start()

func StopDefiling():
	current_state = State.Ended
	label.visible_characters = -1
	timer.stop()

func _on_rich_text_label_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if current_state == State.Defiling:
			StopDefiling()
		else:
			SignalManager.PlayerClickedOnDialogue.emit()
