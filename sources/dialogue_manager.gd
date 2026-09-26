extends Node

@export var dialogues: Array[DialogueResource]
var curr_dialogue_resource: DialogueResource
var dialogues_idx: int = 0

@onready var dialogue: Dialogue = $Dialogue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.PlayerClickedOnDialogue.connect(OnPlayerClickedOnDialogue)
	if dialogues_idx < dialogues.size():
		curr_dialogue_resource = dialogues.get(dialogues_idx)
		dialogue.dialogue_resource = curr_dialogue_resource

func OnPlayerClickedOnDialogue():
	dialogues_idx += 1
	if dialogues_idx < dialogues.size():
		curr_dialogue_resource = dialogues.get(dialogues_idx)
		dialogue.dialogue_resource = curr_dialogue_resource
	else:
		dialogue.hide()