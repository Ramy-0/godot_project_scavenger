extends Control

@onready var fullscreen = $VBoxContainer/VideoFullContainer/VideoFullButton
@onready var maximized = $VBoxContainer/VideoMaxContainer/VideoMaxButton

@onready var masterVolume = $VBoxContainer/AudioMasterContainer/AudioMasterSlider
@onready var musicVolume = $VBoxContainer/AudioMusicContainer/AudioMusicSlider
@onready var sfxVolume = $VBoxContainer/AudioSFXContainer/AudioSFXSlider


func _ready() -> void:
	var video_settings = ConfigFileHandler.load_video_settings()
	fullscreen.button_pressed = video_settings.fullscreen
	maximized.button_pressed = video_settings.maximize
	
	var audio_settings = ConfigFileHandler.load_audio_settings()
	masterVolume.value = min(audio_settings.volume, 1.0) * 100.0
	musicVolume.value = min(audio_settings.music, 1.0) * 100.0
	sfxVolume.value = min(audio_settings.sfx, 1.0) * 100.0
	

func _on_exit_button_pressed() -> void:
	print(ConfigFileHandler.load_audio_settings())
	print(ConfigFileHandler.load_video_settings())
	
	get_tree().change_scene_to_file("res://ui/main_menu.tscn")

func _on_video_full_button_toggled(toggled_on: bool) -> void:
	ConfigFileHandler.save_video_setting("fullscreen", toggled_on)
	print("fullscreen ", toggled_on)
	
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		maximized.disabled = true
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		maximized.disabled = false
		if maximized.button_pressed:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)


func _on_video_max_button_toggled(toggled_on: bool) -> void:
	ConfigFileHandler.save_video_setting("maximize", toggled_on)
	if not fullscreen.button_pressed:
		if toggled_on:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_audio_master_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		ConfigFileHandler.save_audio_setting("volume", masterVolume.value / 100.0)
		print("volume ", masterVolume.value / 100.0)

func _on_audio_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(value/100.0))

func _on_audio_music_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		ConfigFileHandler.save_audio_setting("music", musicVolume.value / 100.0)
		print("Music ", musicVolume.value / 100.0)

func _on_audio_sfx_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		ConfigFileHandler.save_audio_setting("sfx", sfxVolume.value / 100.0)
		print("SFX ", sfxVolume.value / 100.0)

func _on_audio_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(value/100.0))

func _on_audio_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, linear_to_db(value/100.0))
