extends Button

func _ready():
	mouse_entered.connect(OnMouseEnter)
	mouse_exited.connect(OnMouseExit)

func OnMouseEnter():
	MouseManager.ChangeCursor(MouseManager.CURSOR2)
	SoundManager.PlaySound(SoundManager.sound.HOVER)

func OnMouseExit():
	MouseManager.ChangeCursor(MouseManager.CURSOR1)
