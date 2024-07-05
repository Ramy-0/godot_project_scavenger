extends Area2D

class_name HurtBoxV2

@export var parent : CharacterBody2D

func _ready():
	add_to_group(get_parent().get_groups()[0])
	parent = get_parent()

func attacked(damage):
	if parent.has_method("attacked"):
		parent.attacked(damage)
	else:
		parent.health = parent.health - damage
