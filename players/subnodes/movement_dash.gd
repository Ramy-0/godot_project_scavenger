extends MovementClass

func _ready():
	coolDownTimer.wait_time = cool_down

func _process(delta):
	if Input.is_action_just_pressed("kb_space"):
		if coolDownTimer.time_left == 0:
			dash()
			coolDownTimer.start()
		elif coolDownTimer.time_left <= 0.3:
			await coolDownTimer.timeout
			dash()
			coolDownTimer.start()
	
	$ProgressBar.value = coolDownTimer.time_left / cool_down * 100
	$Label.text = str(coolDownTimer.time_left)

func dash():
	get_parent().speed_mult = get_parent().speed_mult * 10
	await get_tree().create_timer(0.1).timeout
	get_parent().speed_mult = get_parent().speed_mult * 0.1
