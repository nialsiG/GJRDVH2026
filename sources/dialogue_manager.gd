@tool
extends Node

# var dialogues_idx: int = 0
# var dialogues: Array[Dialogue]
# var curr_dialogue_res: Dialogue:
# 	set(data):
# 		curr_dialogue_res = data
# 		SignalManager.NextDialogue.emit()
		
# func _ready() -> void:
# 	SignalManager.PlayerClickedOnDialogue.connect(OnPlayerClickedOnDialogue)
# 	SignalManager.NewDialogueArray.connect(OnNewDialogueArray)

# func OnNewDialogueArray(array: Array[Dialogue]):
# 	print("DialogueManager: array=", array)
# 	dialogues = array
# 	dialogues_idx = 0
# 	if dialogues_idx < dialogues.size():
# 		curr_dialogue_res = dialogues.get(dialogues_idx)
# 	print("curr_dialogue_res=", curr_dialogue_res)
# 	StartDialogue()

# func StartDialogue():
# 	SignalManager.DialogueStarted.emit()

# func OnPlayerClickedOnDialogue():
# 	dialogues_idx += 1
# 	if dialogues_idx < dialogues.size():
# 		curr_dialogue_res = dialogues.get(dialogues_idx)
# 	else:
# 		SignalManager.DialogueEnded.emit()

signal dialogue_changed(dialogue: Dialogue)

var dialogue: Dialogue

func _ready() -> void:
	init()

func init() -> void:
	dialogue = dialogue.default()