extends Control


func _on_main_button_pressed():
	SignalManager.StopGame.emit()
