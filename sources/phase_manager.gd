extends Node

var current_phase: EnumCollection.EPhase

func _ready():
	SignalManager.NewGame.connect(Reset)

func Reset():
	change_phase(EnumCollection.EPhase.START)

func NextPhase():
	if current_phase == EnumCollection.EPhase.FRERES:
		SignalManager.GameOver.emit()
		print("GAME OVER!")
	else:
		change_phase(current_phase + 1)

func change_phase(phase: EnumCollection.EPhase):
	current_phase = phase
	SignalManager.OnNextPhase.emit(phase)
