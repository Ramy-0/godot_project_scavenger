extends CanvasLayer

func _process(delta):
	$FPS_Label.text = "FPS : " + str(Engine.get_frames_per_second())
