@tool
extends Resource
class_name MapObjectResource

## Texture of the object
@export_group("Default")
@export var texture: Texture2D:
	set(new_setting):
		texture = new_setting
		changed.emit()

## Texture of the object when it's clicked
@export_group("On Click")
@export var new_texture: Texture2D:
	set(new_setting):
		new_texture = new_setting
		changed.emit()

## List of default dialogues to trigger when the object is clicked
@export_group("On Click")
@export var on_click_default_dialogues: Array[DialogueResource]:
	set(new_setting):
		on_click_default_dialogues = new_setting
		changed.emit()

## List of wise dialogues to trigger when the object is clicked
@export_group("On Click")
@export var on_click_wise_dialogues: Array[DialogueResource]:
	set(new_setting):
		on_click_wise_dialogues = new_setting
		changed.emit()

## List of very_wise dialogues to trigger when the object is clicked
@export_group("On Click")
@export var on_click_very_wise_dialogues: Array[DialogueResource]:
	set(new_setting):
		on_click_very_wise_dialogues = new_setting
		changed.emit()

## List of evil dialogues to trigger when the object is clicked
@export_group("On Click")
@export var on_click_evil_dialogues: Array[DialogueResource]:
	set(new_setting):
		on_click_evil_dialogues = new_setting
		changed.emit()

## List of very_evil dialogues to trigger when the object is clicked
@export_group("On Click")
@export var on_click_very_evil_dialogues: Array[DialogueResource]:
	set(new_setting):
		on_click_very_evil_dialogues = new_setting
		changed.emit()

## Sound effect played when the object is clicked
@export_group("On Click")
@export var sound_effect: SoundManager.sound:
	set(new_setting):
		sound_effect = new_setting
		changed.emit()

## On which phase the object is INTERACTABLE
@export_group("Phase System")
@export var interactable_on_phase: EnumCollection.EPhase:
	set(new_setting):
		interactable_on_phase = new_setting
		changed.emit()

## List of phases when the object is visible
@export_group("Phase System")
@export var visible_on_phases: Array[EnumCollection.EPhase]:
	set(new_setting):
		visible_on_phases = new_setting
		changed.emit()

## Wise points earned when clicking on it
@export_group("Karma System")
@export var wise_points: int = 0:
	set(new_setting):
		wise_points = new_setting
		changed.emit()

## Evils points earned when clicking on it
@export_group("Karma System")
@export var evil_points: int = 0:
	set(new_setting):
		evil_points = new_setting
		changed.emit()


## Minimum of wise_points to trigger very wise dialogue
@export_group("Karma System")
@export var cond_very_wise: int = 0:
	set(new_setting):
		cond_very_wise = new_setting
		changed.emit()

## Minimum of evil_points to trigger very wise dialogue
@export_group("Karma System")
@export var cond_very_evil: int = 0:
	set(new_setting):
		cond_very_evil = new_setting
		changed.emit()

## Choice to add when user choose it
@export_group("Karma System")
@export var choice_to_add: EnumCollection.EChoice = EnumCollection.EChoice.NONE:
	set(new_setting):
		choice_to_add = new_setting
		changed.emit()

## Player must have choosen this choice to trigger very wise dialogue
@export_group("Karma System")
@export var cond_choice_very_wise: EnumCollection.EChoice = EnumCollection.EChoice.NONE:
	set(new_setting):
		cond_choice_very_wise = new_setting
		changed.emit()

## Player must have choosen this choice to trigger very evil dialogue
@export_group("Karma System")
@export var cond_choice_very_evil: EnumCollection.EChoice = EnumCollection.EChoice.NONE:
	set(new_setting):
		cond_choice_very_evil = new_setting
		changed.emit()


# TODO: remove unused property ?
# @export_group("Phase System")
# @export var change_phase: bool:
# 	set(new_setting):
# 		change_phase = new_setting
# 		changed.emit()
