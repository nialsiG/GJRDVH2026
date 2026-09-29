extends Control

@export_category("choice dialogues")
@export var hill_choice_1_text: String
@export var hill_choice_2_text: String
@export var hill_choice_1_map_resource: MapObjectResource
@export var hill_choice_2_map_resource: MapObjectResource

@export var brother_choice_1_text: String
@export var brother_choice_2_text: String
@export var brother_choice_1_map_resource: MapObjectResource
@export var brother_choice_2_map_resource: MapObjectResource

@onready var panel_choice_button_1: PanelChoiceButton = %PanelChoiceButton1
@onready var panel_choice_button_2: PanelChoiceButton = %PanelChoiceButton2
@onready var animation_player: AnimationPlayer = %AnimationPlayer

func _ready():
	if !hill_choice_1_map_resource:
		printerr("hill_choice_1_map_resource is null")
	if !hill_choice_2_map_resource:
		printerr("hill_choice_2_map_resource is null")
	if !brother_choice_1_map_resource:
		printerr("brother_choice_1_map_resource is null")
	if !brother_choice_2_map_resource:
		printerr("brother_choice_2_map_resource is null")
	panel_choice_button_1.pressed.connect(HideChoice)
	panel_choice_button_2.pressed.connect(HideChoice)
	GameManager.game_phase_changed.connect(on_game_phase_changed)
	SignalManager.NewGame.connect(hide)

func _on_main_button_pressed():
	SignalManager.StopGame.emit()

func on_game_phase_changed(phase: Phase):
	print("overlay: on_game_phase_changed")
	match phase.stage:
		Phase.EStage.HILL:
			if phase.state == Phase.EState.CHOICE:
				OnChoiceDisplay(hill_choice_1_map_resource, hill_choice_2_map_resource, hill_choice_1_text, hill_choice_2_text)
		Phase.EStage.BROTHERS:
			if phase.state == Phase.EState.CHOICE:
				OnChoiceDisplay(brother_choice_1_map_resource, brother_choice_2_map_resource, brother_choice_1_text, brother_choice_2_text)


func OnChoiceDisplay(resource_1: MapObjectResource, resource_2: MapObjectResource, choice_text_1: String, choice_text_2: String):
	if !resource_1:
		printerr("resource_1 is null")
		return
	if !resource_2:
		printerr("resource_2 is null")
		return
	print("onchoicedisplay")
	print("choice_text_1", choice_text_1)
	panel_choice_button_1.text = choice_text_1
	panel_choice_button_1.map_object_resource = resource_1
	panel_choice_button_2.text = choice_text_2
	panel_choice_button_2.map_object_resource = resource_2
	await get_tree().create_timer(0.6).timeout
	DisplayChoice()

func DisplayChoice():
	show()
	MusicManager.PlayMusic(MusicManager.music.CHOIX)
	animation_player.play("on_choice_display")

func HideChoice():
	MusicManager.PlayMusic(MusicManager.music.ENVIRONNEMENT)
	animation_player.play("on_choice_hide")
