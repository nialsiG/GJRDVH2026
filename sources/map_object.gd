@tool
extends Node2D
class_name MapObject

@export var map_object_resource: MapObjectResource:
	set(new_resource):
		# Disconnect the signal if the previous resource was not null.
		if map_object_resource != null and map_object_resource.changed.has_connections():
			map_object_resource.changed.disconnect(OnResourceChange)
		map_object_resource = new_resource
		OnResourceChange()
		if map_object_resource != null:
			map_object_resource.changed.connect(OnResourceChange)

@export var interactable: Interactable

@onready var sprite_2d: Sprite2D = %Sprite2D


func _ready():
	OnResourceChange()

func OnResourceChange():
	if !sprite_2d:
		return
	sprite_2d.texture = map_object_resource.texture

func Activate():
	if interactable:
		interactable.collision_shape_2d.disabled = false

func Deactivate():
	if interactable:
		interactable.collision_shape_2d.disabled = true


func _on_area_2d_mouse_shape_entered(shape_idx):
	MouseManager.ChangeCursor(MouseManager.CURSOR2)


func _on_area_2d_mouse_shape_exited(shape_idx):
	MouseManager.ChangeCursor(MouseManager.CURSOR1)
