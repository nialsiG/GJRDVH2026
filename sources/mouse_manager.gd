extends Node

const CURSOR1 = preload("uid://bgbfd5n5uoja0")
const CURSOR2 = preload("uid://1uvfmwicdrth")

func ChangeCursor(cursor):
	Input.set_custom_mouse_cursor(cursor)

func _ready():
	Reset()
	SignalManager.NewGame.connect(Reset)

func Reset():
	ChangeCursor(CURSOR1)
