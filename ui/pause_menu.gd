extends Control

var paused : bool = false

func _ready():
	hide()

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE and not paused:
			show()
			get_tree().paused = true
		elif event.pressed and event.keycode == KEY_ESCAPE and paused:
			hide()
			get_tree().paused = false
