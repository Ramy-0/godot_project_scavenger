extends Node2D

class_name WeaponBelt

@export var weapon1 : WeaponClass
@export var weapon2 : WeaponClass

func _ready():
	weapon1.active = true
	weapon2.active = false
	weapon1.set_as_active()
	weapon2.set_as_inactive()

func _process(delta):
	if Input.is_action_just_pressed("kb_q"):
		print("switch")
		if weapon1.active and not weapon2.active:
			weapon1.active = false
			weapon2.active = true
			weapon1.set_as_inactive()
			weapon2.set_as_active()
		elif weapon2.active and not weapon1.active:
			weapon2.active = false
			weapon1.active = true
			weapon2.set_as_inactive()
			weapon1.set_as_active()
	
