extends Node2D

class_name WeaponBelt

@export var weapon1 : WeaponClass
@export var weapon2 : WeaponClass

func _process(delta):
	if Input.is_action_just_pressed("kb_q"):
		print("switch")
