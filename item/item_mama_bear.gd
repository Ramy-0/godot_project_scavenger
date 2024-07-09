extends ItemClass

func use_when_attacked():
	#make the calculation better
	get_parent().parent.hurtBox.damage *= (1 - log(1 + 0.2 * amount))
