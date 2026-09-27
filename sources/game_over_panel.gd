extends Control

@export_category("EndDialogues")

@export var fin_sage_but_playedchaos: String
@export var fin_sage_and_playedsage: String
@export var fin_chaos_but_playedsage: String
@export var fin_chaos_but_playedchaos: String
@export var fin_conclusion_sage: String
@export var fin_conclusion_chaos: String
@export var fin_conclusion_fin: String

@export var texture_bad: Texture2D
@export var texture_good: Texture2D

@onready var bg_panel: TextureRect = $BGPanel
@onready var rich_text_label: RichTextLabel = %RichTextLabel

enum fin {
	SAGE,
	CHAOS
}

enum played {
	SAGE,
	CHAOS
}


func _ready():
	SignalManager.NewGame.connect(Hide)
	SignalManager.GameOver.connect(OnGameOver)
	SignalManager.StopGame.connect(Hide)

func OnGameOver():
	rich_text_label.clear()
	var current_fin: fin
	if KarmaManager.state == EnumCollection.EKarma.EVIL:
		current_fin = fin.CHAOS
	else:
		current_fin = fin.SAGE
	var current_played: played
	if KarmaManager.evil_points > KarmaManager.wise_points:
		current_played = played.CHAOS
	else:
		current_played = played.SAGE
	
	var text: String = ""
	match current_fin:
		played.SAGE:
			MusicManager.PlayMusic(MusicManager.music.GOOD_ENDING)
			bg_panel.texture = texture_good
			text += tr(fin_conclusion_sage)
			text += "\n"
			match current_played:
				fin.SAGE:
					text += tr(fin_sage_and_playedsage)
				fin.CHAOS:
					text += tr(fin_sage_but_playedchaos)
		played.CHAOS:
			MusicManager.PlayMusic(MusicManager.music.BAD_ENDING)
			bg_panel.texture = texture_bad
			text += tr(fin_conclusion_chaos)
			text += "\n"
			match current_played:
				fin.SAGE:
					text += tr(fin_chaos_but_playedsage)
				fin.CHAOS:
					text += tr(fin_chaos_but_playedchaos)
	text += "\n"
	text += tr(fin_conclusion_fin)
	rich_text_label.append_text(text)
	Show()

func Show():
	show()

func Hide():
	hide()

func _on_back_to_main_button_pressed():
	SignalManager.StopGame.emit()
