@tool
extends Resource
class_name DialogueResource

@export_category("Data")
@export var loc_key: String:
    set(new_setting):
        loc_key = new_setting
        changed.emit()

@export_category("Data")
@export var bark_loc_key: String:
    set(new_setting):
        bark_loc_key = new_setting
        changed.emit()