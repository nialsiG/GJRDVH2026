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

func OnNextPhase(phase: EnumCollection.EPhase):
	match phase:
		EnumCollection.EPhase.COLLINE:
			OnChoiceDisplay(colline_choice_1_map_resource, colline_choice_2_map_resource, colline_choice_1_text, colline_choice_2_text)
		EnumCollection.EPhase.FRERES:
			OnChoiceDisplay(brother_choice_1_map_resource, brother_choice_2_map_resource, brother_choice_1_text, brother_choice_2_text)


func _ready():
	panel_choice_button_1.pressed.connect(HideChoice)
	panel_choice_button_2.pressed.connect(HideChoice)
	SignalManager.OnNextPhase.connect(OnNextPhase)

func OnChoiceDisplay(resource_1: MapObjectResource, resource_2: MapObjectResource, choice_text_1: String, choice_text_2: String):
	panel_choice_button_1.text = choice_text_1
	panel_choice_button_1.map_object_resource = resource_1
	panel_choice_button_2.text = choice_text_2
	panel_choice_button_2.map_object_resource = resource_2
	DisplayChoice()

func DisplayChoice():
	animation_player.play("on_choice_display")

func HideChoice():
	print("test")
	animation_player.play("on_choice_hide")
