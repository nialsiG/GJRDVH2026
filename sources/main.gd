extends Control

@onready var credit_panel = %CreditPanel

func _ready():
	SignalManager.StopGame.connect(OnStopGame)

func _on_start_button_pressed():
	hide()
	SignalManager.NewGame.emit()

func OnStopGame():
	show()

func _on_credit_button_pressed():
	credit_panel.show()

func _on_close_credit_button_pressed():
	credit_panel.hide()
