extends Area2D

class_name PlayerHurtbox

var damage:float
var effects:Array

signal hurtbox_attacked

func attacked(p_damage):
	damage = p_damage
	emit_signal("hurtbox_attacked")
	if get_parent().has_method("attacked"):
		get_parent().attacked(damage)
	else:
		get_parent().health = get_parent().health - damage
