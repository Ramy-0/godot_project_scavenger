extends ItemClass

func use_when_critical(hitbox, hurtbox):
	get_parent().parent.health += hitbox.damage * amount
	
