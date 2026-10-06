extends AudioListener2D

func _physics_process(_delta):
	global_position = get_global_mouse_position()
