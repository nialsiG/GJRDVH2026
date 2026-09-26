@tool
extends Area2D
class_name Interactable

@onready var collision_shape_2d = $CollisionShape2D
@onready var sprite_2d: Sprite2D = %Sprite2D

func _ready() -> void:
	pass

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("interact"):
		SignalManager.PlayerClickedOnMe.emit(get_parent())
