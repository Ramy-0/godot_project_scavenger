extends Area2D

class_name PlayerHitBoxMoving

@export var damage : int
@export var delete_after_hit : bool = false

signal hitbox_attack

func _ready():
	damage = get_parent().damage

func _on_area_entered(area):
	#print(area)
	emit_signal("hitbox_attack")
	area.attacked(damage)
	if delete_after_hit:
		get_parent().queue_free()
