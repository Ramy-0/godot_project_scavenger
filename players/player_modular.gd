extends PlayerClass

func _process(delta):
	$PCTrackPoint.position = (get_viewport().get_mouse_position() - Vector2(get_viewport_rect().size.x/2, get_viewport_rect().size.y/2))/3
	$CanvasLayer/CoinsLabel.text = "Coins : " + str(coins)
	
	if velocity != Vector2.ZERO:
		$AnimatedSprite2D.speed_scale = 1
	else:
		$AnimatedSprite2D.speed_scale = 0
	
	if get_local_mouse_position().x > 0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true 

func _on_player_hurt_box_hurtbox_attacked() -> void:
	pass
	
	#var types: = [ProCam.SCREEN_SHAKE_RANDOM]
	#var duration: = 0.3
	#var magnitude: = 3.5
	#var speed: = 20.0
	#ProCam.start_shake(types, duration, magnitude, speed)
	
	#$CanvasModulate.color = Color.ROSY_BROWN
	#await get_tree().create_timer(0.02).timeout
	#$CanvasModulate.color = Color.WHITE
