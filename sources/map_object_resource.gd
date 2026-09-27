@tool
extends Resource
class_name MapObjectResource

@export_category("Data")
@export var texture: Texture2D:
	set(new_setting):
		texture = new_setting
		changed.emit()

@export var interactable_on_phase: EnumCollection.EPhase:
	set(new_setting):
		interactable_on_phase = new_setting
		changed.emit()

@export var visible_on_phases: Array[EnumCollection.EPhase]:
	set(new_setting):
		visible_on_phases = new_setting
		changed.emit()

@export_category("On Click")
@export var new_texture: Texture2D:
	set(new_setting):
		new_texture = new_setting
		changed.emit()

@export var on_click_dialogue_array: Array[DialogueResource]:
	set(new_setting):
		on_click_dialogue_array = new_setting
		changed.emit()

@export var sound_effect: SoundManager.sound:
	set(new_setting):
		sound_effect = new_setting
		changed.emit()

@export var change_phase: bool:
	set(new_setting):
		change_phase = new_setting
		changed.emit()
