extends Control

func _ready():
	SignalManager.StopGame.connect(OnStopGame)

func _on_start_button_pressed():
	hide()
	SignalManager.NewGame.emit()

func OnStopGame():
	show()
