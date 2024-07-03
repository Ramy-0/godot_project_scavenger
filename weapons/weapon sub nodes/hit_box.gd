extends Area2D

class_name HitBox

func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		if body.has_method("hit"):
			body.hit(get_parent().damage)
	queue_free()

func _on_area_entered(area):
	if area.is_in_group("HurtBox") and area.get_parent().is_in_group("Enemy"):
		if area.has_method("attacked"):
			area.attacked(get_parent().damage)
		queue_free()
