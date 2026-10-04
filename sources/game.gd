@tool
class_name Game
extends Resource

signal new_phase(phase: Phase)

var phase_idx: int = 0

@export var phases: Array[Phase]:
    set(new_value):
        phases = new_value
        changed.emit()

var played_phases: Array[Phase]:
    set(new_value):
        played_phases = new_value
        changed.emit()

var phase: Phase:
    set(new_value):
        phase = new_value
        new_phase.emit(new_value)
        changed.emit()

func on_new_game() -> void:
    print("phase: on_new_game")
    phase_idx = 0
    played_phases = []
    load_new_phase()
    if phase == null:
        printerr("phase is null")
        return

func on_dialogue_ui_on_clicked_on_dialogue() -> void:
    phase.load_new_dialogue()

func on_phase_end_dialogues() -> void:
    load_new_phase()

func on_choice_is_made(choice: EnumCollection.EChoice) -> void:
    print("game: on_choice_is_made")
    phase.on_choice_is_made(choice)

func load_new_phase() -> void:
    var tmp = phases.get(phase_idx)
    if !tmp:
        SignalManager.GameOver.emit()
        return
    tmp.reset()
    phase_idx += 1
    if !has_phase_already_been_played(tmp) && tmp._check_conditions():
            phase = tmp
            played_phases.append(phase)
            phase.play_phase_music()
            phase.load_new_dialogue()
    else:
        print("phase could not be loaded")
        load_new_phase()

func has_phase_already_been_played(ph: Phase) -> bool:
    if !ph:
        printerr("ph is null")
        return false
    
    for p in played_phases:
        if p.stage == ph.stage && p.state == ph.state:
            return true

    return false
