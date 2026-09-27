extends Control

@export_category("choice dialogues")
@export var colline_choice_1_text: String
@export var colline_choice_2_text: String
@export var colline_choice_1_map_resource: MapObjectResource
@export var colline_choice_2_map_resource: MapObjectResource

@export var brother_choice_1_text: String
@export var brother_choice_2_text: String
@export var brother_choice_1_map_resource: MapObjectResource
@export var brother_choice_2_map_resource: MapObjectResource

@onready var panel_choice_button_1: PanelChoiceButton = %PanelChoiceButton1
@onready var panel_choice_button_2: PanelChoiceButton = %PanelChoiceButton2
@onready var animation_player: AnimationPlayer = %AnimationPlayer

func _on_main_button_pressed():
	SignalManager.StopGame.emit()

func OnNextPhaseState(phase: EnumCollection.EPhase, state: PhaseManager.EPhaseState):
	print('phase:', EnumCollection.EPhase.keys()[phase])
	match phase:
		EnumCollection.EPhase.COLLINE:
			if state == PhaseManager.EPhaseState.CHOICE:
				OnChoiceDisplay(colline_choice_1_map_resource, colline_choice_2_map_resource, colline_choice_1_text, colline_choice_2_text)
		EnumCollection.EPhase.FRERES:
			if state == PhaseManager.EPhaseState.CHOICE:
				OnChoiceDisplay(brother_choice_1_map_resource, brother_choice_2_map_resource, brother_choice_1_text, brother_choice_2_text)


func _ready():
	panel_choice_button_1.pressed.connect(HideChoice)
	panel_choice_button_2.pressed.connect(HideChoice)
	SignalManager.NextPhaseState.connect(OnNextPhaseState)
	SignalManager.NewGame.connect(hide)


func OnChoiceDisplay(resource_1: MapObjectResource, resource_2: MapObjectResource, choice_text_1: String, choice_text_2: String):
	print("onchoicedisplay")
	print("choice_text_1", choice_text_1)
	panel_choice_button_1.text = choice_text_1
	panel_choice_button_1.map_object_resource = resource_1
	panel_choice_button_2.text = choice_text_2
	panel_choice_button_2.map_object_resource = resource_2
	await get_tree().create_timer(0.2).timeout
	DisplayChoice()

func DisplayChoice():
	show()
	MusicManager.PlayMusic(MusicManager.music.CHOIX)
	animation_player.play("on_choice_display")

func HideChoice():
	MusicManager.PlayMusic(MusicManager.music.ENVIRONNEMENT)
	animation_player.play("on_choice_hide")
