extends ItemClass

func use_when_attacking(hitbox, hurtbox):
	if randf() > (1 - 0.1 * amount):
		if hurtbox.parent.has_node("Status_Handler"):
			hurtbox.parent.statusHandler.status["bleed"] = 5.0
			hurtbox.parent.statusHandler.bleed_mult += 1
			print("bleed")
