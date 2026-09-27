@tool
extends Node

var dialogues_idx: int = 0
var dialogues: Array[DialogueResource]
var curr_dialogue_res: DialogueResource:
	set(data):
		curr_dialogue_res = data
		SignalManager.NextDialogue.emit()
		
func _ready() -> void:
	SignalManager.PlayerClickedOnDialogue.connect(OnPlayerClickedOnDialogue)
	SignalManager.NewDialogueArray.connect(OnNewDialogueArray)

func OnNewDialogueArray(array: Array[DialogueResource]):
	print("DialogueManager: array=", array)
	dialogues = array
	dialogues_idx = 0
	if dialogues_idx < dialogues.size():
		curr_dialogue_res = dialogues.get(dialogues_idx)
	print("curr_dialogue_res=", curr_dialogue_res)
	StartDialogue()

func StartDialogue():
	SignalManager.DialogueStarted.emit()

func OnPlayerClickedOnDialogue():
	dialogues_idx += 1
	if dialogues_idx < dialogues.size():
		curr_dialogue_res = dialogues.get(dialogues_idx)
	else:
		SignalManager.DialogueEnded.emit()