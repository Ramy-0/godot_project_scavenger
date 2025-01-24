extends Control

var paused : bool = false
@export var world : Node2D

func _ready():
	#world = MyFuncs.get_fst_parent_in(self, "World")
	hide()

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE and not paused:
			show()
			paused = true
			world.get_tree().paused = true
		elif event.pressed and event.keycode == KEY_ESCAPE and paused:
			hide()
			paused = false
			world.get_tree().paused = false


func _on_button_pressed() -> void:
	hide()
	paused = false
	world.get_tree().paused = false

func _on_cont_button_pressed() -> void:
	hide()
	paused = false
	world.get_tree().paused = false

func _on_set_button_pressed() -> void:
	pass # Replace with function body.

func _on_exit_button_pressed() -> void:
	world.get_tree().paused = false
	get_tree().change_scene_to_file("res://ui/main_menu.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
