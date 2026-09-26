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

const OUTLINE_SHADER_MATERIAL = preload("uid://desy0lgw0pa8s")

func _ready():
	OnResourceChange()
	if interactable:
		interactable.clicked.connect(OnMapObjectClicked)
		interactable.mouse_entered.connect(OnMapObjectHovered)
		interactable.mouse_exited.connect(OnMapObjectExited)

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

	
func Show():
	sprite_2d.modulate = Color.TRANSPARENT
	show()
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "modulate", Color.WHITE, 0.5)

func Hide():
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "modulate", Color.TRANSPARENT, 0.5)
	tween.tween_callback(hide)


func ChangeTexture(new_texture: Texture2D):
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "modulate", Color.TRANSPARENT, 0.5)
	await tween.finished
	sprite_2d.texture = new_texture
	tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "modulate", Color.WHITE, 0.5)


func OnMapObjectHovered():
	MouseManager.ChangeCursor(MouseManager.CURSOR2)
	sprite_2d.material = OUTLINE_SHADER_MATERIAL

func OnMapObjectExited():
	MouseManager.ChangeCursor(MouseManager.CURSOR1)
	sprite_2d.material = null

func OnMapObjectClicked():
	Deactivate()
	if map_object_resource.new_texture:
		ChangeTexture(map_object_resource.new_texture)
	SignalManager.PlayerClickedOnMe.emit(self)
