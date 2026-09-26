@tool
extends Area2D
class_name Interactable

@onready var collision_shape_2d = $CollisionShape2D

signal clicked

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("interact"):
		clicked.emit()
