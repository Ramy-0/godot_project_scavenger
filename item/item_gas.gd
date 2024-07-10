extends ItemClass

func use_when_attacking(hitbox, hurtbox):
	if randf() > (1 - 0.05 ):
		if hurtbox.parent.has_node("Status_Handler"):
			hurtbox.parent.statusHandler.status["burn"] += 3.0
			#hurtbox.parent.statusHandler.burn_mult += 1
			print("burn")
	
	if randf() > (1 - 0.1 * amount ):
		if hurtbox.parent.has_node("Status_Handler"):
			#hurtbox.parent.statusHandler.status["burn"] += 3.0
			hurtbox.parent.statusHandler.burn_mult += 1
			print("burn")
