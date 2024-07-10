extends ItemClass

func use_when_attacking(hitbox, hurtbox):
	if randf() > (1 - 0.1 * amount):
		hitbox.damage *= 2
		print("crit")
