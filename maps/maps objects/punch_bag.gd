extends StaticBody2D

@onready var label = $Label

func hit(dmg):
	print("ouch")
	label.text = str(dmg)
