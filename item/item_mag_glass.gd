extends ItemClass

func use_when_attacking(hitbox, hurtbox):
	if randf() > (1 - 0.1 * amount):
		get_parent().on_critical(hitbox, hurtbox)
