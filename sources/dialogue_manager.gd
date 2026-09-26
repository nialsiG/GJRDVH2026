@tool
extends Node

var dialogues_idx: int = 0
var dialogues: Array[DialogueResource]
var curr_dialogue_resource: DialogueResource:
	set(data):
		curr_dialogue_resource = data
		SignalManager.NextDialogue.emit()

func _ready() -> void:
	SignalManager.PlayerClickedOnDialogue.connect(OnPlayerClickedOnDialogue)
	if dialogues_idx < dialogues.size():
		curr_dialogue_resource = dialogues.get(dialogues_idx)
	StartDialogue()

func StartDialogue():
	SignalManager.DialogueStarted.emit()

func OnPlayerClickedOnDialogue():
	dialogues_idx += 1
	if dialogues_idx < dialogues.size():
		curr_dialogue_resource = dialogues.get(dialogues_idx)
	else:
		SignalManager.DialogueEnded.emit()
