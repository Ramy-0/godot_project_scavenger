extends Area2D

class_name PlayerHurtbox

func attacked(damage):
	if get_parent().has_method("attacked"):
		get_parent().attacked(damage)
	else:
		get_parent().health = get_parent().health - damage
