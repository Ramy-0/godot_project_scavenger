extends PlayerClass

func _process(delta):
	$PCTrackPoint.position = (get_viewport().get_mouse_position() - Vector2(get_viewport_rect().size.x/2, get_viewport_rect().size.y/2))/3
