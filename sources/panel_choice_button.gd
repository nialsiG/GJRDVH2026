@tool
extends Button
class_name PanelChoiceButton

@export var map_object_resource: MapObjectResource

@onready var texture_rect: TextureRect = %TextureRect
@onready var label: Label = %Label

func _on_pressed():
	print("panel_choice_button: _on_pressed")
	# Changes on click
	if !map_object_resource:
		printerr("map_object_resource is null")
		return
	if map_object_resource.sound_effect:
		SoundManager.PlaySound(map_object_resource.sound_effect)
	else:
		SoundManager.PlaySound(SoundManager.sound.CLICK)
	KarmaManager.add_wise_points(map_object_resource.wise_points)
	KarmaManager.add_evil_points(map_object_resource.evil_points)
	KarmaManager.add_choice(map_object_resource.choice_to_add)
