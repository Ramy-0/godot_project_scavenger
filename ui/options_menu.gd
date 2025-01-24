extends Control

@onready var fullscreen = $VBoxContainer/VideoContainer/CheckButton
@onready var volume = $VBoxContainer/AudioContainer/HSlider

func _ready() -> void:
	var video_settings = ConfigFileHandler.load_video_settings()
	fullscreen.button_pressed = video_settings.fullscreen
	
	var audio_settings = ConfigFileHandler.load_audio_settings()
	volume.value = min(audio_settings.volume, 1.0) * 100.0

func _on_exit_button_pressed() -> void:
	print(ConfigFileHandler.load_audio_settings())
	print(ConfigFileHandler.load_video_settings())
	
	get_tree().change_scene_to_file("res://ui/main_menu.tscn")

func _on_check_button_toggled(toggled_on: bool) -> void:
	ConfigFileHandler.save_video_setting("fullscreen", toggled_on)
	print("fullscreen ", toggled_on)

func _on_h_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		ConfigFileHandler.save_audio_setting("volume", volume.value / 100.0)
		print("volume ", volume.value / 100.0)

func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(value/100.0))
