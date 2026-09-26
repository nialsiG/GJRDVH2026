@tool
extends Control
class_name Dialogue

@export var dialogue_resource: DialogueResource:
    set(new_resource):
        if dialogue_resource != null and dialogue_resource.changed.has_connections():
            dialogue_resource.changed.disconnect(OnResourceChange)
        dialogue_resource = new_resource
        OnResourceChange()
        if dialogue_resource != null:
            dialogue_resource.changed.connect(OnResourceChange)

@onready var label: RichTextLabel = $RichTextLabel

func _ready() -> void:
    SignalManager.PlayerIsIdle.connect(OnPlayerIsIdle)
    OnResourceChange()

func OnResourceChange():
    if !label:
        return
    label.clear()
    var loc_str = tr(dialogue_resource.loc_key)
    label.append_text(loc_str)

func OnPlayerIsIdle():
    if !label:
        return
    label.clear()
    var loc_str = tr(dialogue_resource.bark_loc_key)
    label.append_text(loc_str)