extends Node

signal game_phase_changed(phase: Phase)

const GAME: Game = preload("uid://cm3kxciuxce8f")

func _ready() -> void:
    TranslationServer.set_locale("french")
    if !GAME:
        printerr("game is null")
    GAME.new_phase.connect(on_new_phase)
    SignalManager.NewGame.connect(GAME.on_new_game)
    SignalManager.DialogueUIClickedOnDialogue.connect(GAME.on_dialogue_ui_on_clicked_on_dialogue)
    SignalManager.PhaseEnd.connect(GAME.on_phase_end_dialogues)
    SignalManager.ChoiceIsMade.connect(GAME.on_choice_is_made)
    
func on_new_phase(phase: Phase) -> void:
    print("game_manager: on_new_phase")
    SoundManager.stop_ambiance()
    game_phase_changed.emit(phase)