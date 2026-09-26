@tool
extends Control
class_name Dialogue

enum State {
    Defiling,
    Ended
}

@export var dialogue_resource: DialogueResource:
    set(new_resource):
        if dialogue_resource != null and dialogue_resource.changed.has_connections():
            dialogue_resource.changed.disconnect(OnResourceChange)
        dialogue_resource = new_resource
        OnResourceChange()
        if dialogue_resource != null:
            dialogue_resource.changed.connect(OnResourceChange)

@onready var label: RichTextLabel = $RichTextLabel
@onready var timer: Timer = $Timer

var current_state: State = State.Defiling

func _ready() -> void:
    SignalManager.PlayerIsIdle.connect(OnPlayerIsIdle)
    OnResourceChange()

func OnResourceChange():
    if !label:
        return
    label.clear()
    var loc_str = tr(dialogue_resource.loc_key)
    label.append_text(loc_str)
    StartDefiling()

func OnPlayerIsIdle():
    if !label:
        return
    label.clear()
    var loc_str = tr(dialogue_resource.bark_loc_key)
    label.append_text(loc_str)

func _on_gui_input(event: InputEvent) -> void:
    if event.is_action_pressed("interact"):
        pass


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