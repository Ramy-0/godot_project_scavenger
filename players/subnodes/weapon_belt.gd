extends Node2D

class_name WeaponBelt

@export var weapon1 : WeaponClass
@export var weapon2 : WeaponClass
@export var weaponUlt : UltWeaponClass

var last_used : int

func _ready():
	weapon1.active = true
	weapon2.active = false
	weaponUlt.active = false
	weapon1.set_as_active()
	weapon2.set_as_inactive()
	weaponUlt.set_as_inactive()
	last_used = 1

func _process(delta):
	if Input.is_action_just_pressed("kb_q"):
		switch_weapons()
	
	if Input.is_action_just_pressed("kb_alt"):
		switch_ult()



func switch_weapons():
	if weapon1.active and not weapon2.active:
		weapon1.active = false
		weapon2.active = true
		weapon1.set_as_inactive()
		weapon2.set_as_active()
		last_used = 2
	elif weapon2.active and not weapon1.active:
		weapon2.active = false
		weapon1.active = true
		weapon2.set_as_inactive()
		weapon1.set_as_active()
		last_used = 1

func switch_ult():
	if not weaponUlt.active:
		weaponUlt.set_as_active()
		weaponUlt.active = true
		match last_used:
			1:
				weapon1.set_as_inactive()
				weapon1.active = false
			2:
				weapon2.set_as_inactive()
				weapon2.active = false
	elif weaponUlt.active:
		weaponUlt.set_as_inactive()
		weaponUlt.active = false
		match last_used:
			1:
				weapon1.set_as_active()
				weapon1.active = true
			2:
				weapon2.set_as_active()
				weapon2.active = true
