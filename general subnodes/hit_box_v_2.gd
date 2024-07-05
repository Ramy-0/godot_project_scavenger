extends Area2D

class_name HitBoxV2

@export var parent_group : String
@export var target_group : String
@export var damage : int
@export var delete_after_hit : bool = false

func _ready():
	parent_group = get_parent().get_groups()[0]
	add_to_group(parent_group)
	print(get_groups())
	
	if is_in_group("Player"):
		target_group = "Enemy"
	elif is_in_group("Enemy"):
		target_group = "Player"
	print(target_group)
	
	damage = get_parent().damage
	
	get_child(0).disabled = true

func _on_area_entered(area):
	print("hitBox hit")
	print(target_group, area.get_parent().get_groups())
	if area.get_parent().is_in_group(target_group):
		print("area attacked")
		area.attacked(damage)
		if delete_after_hit:
			get_parent().queue_free()
