extends Area2D

class_name EnemyHurtbox

var parent : CharacterBody2D

signal hurtbox_attacked

func _ready():
	parent = get_parent()

func attacked(damage):
	if get_parent().has_method("attacked"):
		get_parent().attacked(damage)
	else:
		get_parent().health = get_parent().health - damage
