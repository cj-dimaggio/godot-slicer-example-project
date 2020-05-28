extends Spatial

var captured_mouse = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	captured_mouse = true

func _input(event):
	if event.is_action_pressed('ui_cancel'):
		if self.captured_mouse:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			captured_mouse = false
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			captured_mouse = true
