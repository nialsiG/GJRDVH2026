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

## List of dialogues to trigger when the object is clicked
@export_group("On Click")
@export var on_click_dialogue_array: Array[DialogueResource]:
	set(new_setting):
		on_click_dialogue_array = new_setting
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

# TODO: remove unused property ?
# @export_group("Phase System")
# @export var change_phase: bool:
# 	set(new_setting):
# 		change_phase = new_setting
# 		changed.emit()
