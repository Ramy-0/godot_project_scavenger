extends ItemClass

func use(p_amount):
	get_parent().parent.max_health = get_parent().parent.base_health * (1.0 + 0.1*p_amount)
