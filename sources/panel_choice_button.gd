@tool
extends Button
class_name PanelChoiceButton

@export var map_object_resource: MapObjectResource

func _GetDialoguesFromRes() -> Array[DialogueResource]:
	if KarmaManager.state == EnumCollection.EKarma.WISE:
		if map_object_resource.on_interact_very_dialogues and KarmaManager.wise_points >= map_object_resource.cond_very_wise:
			print("very_wise")
			return map_object_resource.on_interact_very_dialogues
		else:
			print("wise")
			return map_object_resource.on_interact_very_dialogues
	elif KarmaManager.state == EnumCollection.EKarma.EVIL:
		if map_object_resource.on_interact_very_dialogues and KarmaManager.evil_points >= map_object_resource.cond_very_evil:
			print("very_evil")
			return map_object_resource.on_interact_very_dialogues
		else:
			print("evil")
			return map_object_resource.on_interact_evil_dialogues
	else:
		print("default")
		return map_object_resource.on_interact_dialogues

func _on_pressed():
	# Changes on click
	if !map_object_resource:
		return
	KarmaManager.add_choice(map_object_resource.choice_to_add)
	#if map_object_resource.new_texture:
		#ChangeTexture(map_object_resource.new_texture)
	var dialogues: Array[DialogueResource] = _GetDialoguesFromRes()
	if dialogues:
		SignalManager.NewDialogueArray.emit(dialogues)
		#print("MapObject: map_object_resource.on_interact_dialogue_array=", map_object_resource.on_interact_dialogue_array)
	if map_object_resource.sound_effect:
		SoundManager.PlaySound(map_object_resource.sound_effect)
	else:
		SoundManager.PlaySound(SoundManager.sound.CLICK)
	KarmaManager.add_wise_points(map_object_resource.wise_points)
	KarmaManager.add_evil_points(map_object_resource.evil_points)
