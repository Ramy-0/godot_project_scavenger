extends Area2D

class_name PlayerHitBoxMoving

@export var damage : int
@export var delete_after_hit : bool = false



func _on_area_entered(area):
	print(area)
	area.attacked(get_parent().damage)
	if delete_after_hit:
		queue_free()
