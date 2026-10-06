extends Control

@onready var credit_panel = %CreditPanel
@onready var animation_player: AnimationPlayer = %AnimationPlayer

func _ready():
	SignalManager.StopGame.connect(OnStopGame)
	OnStopGame()

func _on_start_button_pressed():
	SignalManager.NewGame.emit()
	animation_player.play("on_hide")
	await animation_player.animation_finished
	hide()
	SoundManager.PlayAmbiance(SoundManager.ambiance.NONE)

func OnStopGame():
	credit_panel.hide()
	animation_player.play("on_show")
	SoundManager.PlayAmbiance(SoundManager.ambiance.RIVER)
	show()

func _on_credit_button_pressed():
	animation_player.play("show_credit")

func _on_close_credit_button_pressed():
	animation_player.play("hide_credit")
