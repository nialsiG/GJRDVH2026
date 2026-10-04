@tool
class_name Phase
extends Resource

enum EStage {
    START,
    HILL,
    ALLIES,
    TREE,
    ANIMAL,
    BROTHERS,
    NONE
}

enum EState {
    START,
    CHOICE,
    END
}
@export var dialogues: Array[Dialogue]:
    set(new_value):
        dialogues = new_value
        changed.emit()

@export var stage: EStage = EStage.START
@export var state: EState = EState.START
@export var cond_choices: Array[EnumCollection.EChoice] = []
@export var cond_wise_points: int = 0
@export var cond_evil_points: int = 0

var dialogue_idx: int = 0

func reset() -> void:
    dialogue_idx = 0

func on_choice_is_made(_choice: EnumCollection.EChoice) -> void:
    SignalManager.PhaseEnd.emit()

func load_new_dialogue() -> void:
        _emit_dialogue()

func _emit_dialogue() -> void:
    if dialogue_idx < dialogues.size():
        var dialogue: Dialogue = dialogues[dialogue_idx]
        print("dialogue=", dialogue)
        SignalManager.PhaseNewDialogue.emit(dialogue)
        dialogue_idx += 1
    elif state != EState.CHOICE:
        SignalManager.PhaseEnd.emit()
    else:
        SignalManager.PhaseEndChoiceDialogue.emit(self)

func _check_conditions() -> bool:
    if KarmaManager.wise_points < cond_wise_points:
        print_debug("not enough wise_points: ", KarmaManager.wise_points, " <", cond_wise_points)
        return false
    if KarmaManager.evil_points < cond_evil_points:
        print_debug("not enough evil_points: ", KarmaManager.evil_points, " <", cond_evil_points)
        return false

    for c in cond_choices:
        if !KarmaManager.choices_made.has(c):
            return false
    return true
