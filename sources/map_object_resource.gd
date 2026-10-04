@tool
extends Resource
class_name MapObjectResource

## Texture of the object
@export_group("Default")
@export var texture: Texture2D:
	set(new_setting):
		texture = new_setting
		changed.emit()

@export_group("Default")
@export var default_visible: bool = false

## Texture of the object when it's clicked
@export_group("Behavior/OnInteract")
@export var new_texture: Texture2D:
	set(new_setting):
		new_texture = new_setting
		changed.emit()

## Sound effect played when the object is clicked
@export_group("Behavior/OnInteract")
@export var sound_effect: SoundManager.sound:
	set(new_setting):
		sound_effect = new_setting
		changed.emit()

## Ambiance played when the object is clicked
@export_group("Behavior/OnInteract")
@export var ambiance_sound: SoundManager.ambiance = SoundManager.ambiance.NONE:
	set(new_setting):
		ambiance_sound = new_setting
		changed.emit()

@export_group("Behavior/Removal")
@export var remove_if_choice_is_made: EnumCollection.EChoice = EnumCollection.EChoice.NONE:
	set(new_setting):
		remove_if_choice_is_made = new_setting
		changed.emit()

@export var is_map_with_river: bool = false:
	set(new_setting):
		is_map_with_river = new_setting
		changed.emit()

## On which phase the object is INTERACTABLE
@export_group("Phase System")
@export var interactable_on_phase_stage: Phase.EStage:
	set(new_setting):
		interactable_on_phase_stage = new_setting
		changed.emit()

## List of phases when the object is visible
@export_group("Phase System")
@export var visible_on_phases: Array[Phase.EStage]:
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