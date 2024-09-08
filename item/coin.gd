extends RigidBody2D

@export var amount: int = 1

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var tw = create_tween()
		tw.tween_property(self, "global_position", body.global_position, 0.2)
		await tw.finished
		body.coins += amount
		queue_free()
