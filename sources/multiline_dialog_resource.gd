@tool
extends Resource
class_name MultilineDialogResource

@export var dialog_resources: Array[Dialogue]:
	set(new_setting):
		dialog_resources = new_setting
		changed.emit()
