extends CharacterBody2D

@export var health: float = 100.0
@export var dmg: float = 12.0



func _on_activate_area_body_entered(body):
	if body.is_in_group("Player"):
		print("Player spoted")


func _on_attack_area_body_entered(body):
	if body.is_in_group("Player"):
		print("bite")
