extends Area2D

class_name HurtBox

@onready var parent = get_parent()

func _ready():
	#doesnt really work must add group manually
	if parent.is_in_group("Player"):
		add_to_group("Player")
	elif parent.is_in_group("Enemy"):
		add_to_group("Enemy")
	

func attacked(damage):
	print("player hurt for ", damage)
	parent.health = parent.health - damage
