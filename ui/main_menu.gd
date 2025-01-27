extends Control

func _ready() -> void:
	var video_settings = ConfigFileHandler.load_video_settings()
	#print(video_settings)
	if video_settings.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
		if video_settings.maximize:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	
	var audio_settings = ConfigFileHandler.load_audio_settings()
	#print(audio_settings)
	AudioServer.set_bus_volume_db(0, linear_to_db(audio_settings.volume))
	AudioServer.set_bus_volume_db(1, linear_to_db(audio_settings.music))
	AudioServer.set_bus_volume_db(2, linear_to_db(audio_settings.sfx))

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://ui/start_menu.tscn")

func _on_option_button_pressed():
	get_tree().change_scene_to_file("res://ui/options_menu.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
