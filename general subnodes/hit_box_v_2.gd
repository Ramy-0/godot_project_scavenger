extends Area2D

class_name HitBoxV2

@export var parent_group : String
@export var target_group : String
@export var damage : int

func _ready():
	parent_group = get_parent().get_groups()[0]
	add_to_group(parent_group)
	#print(get_groups())
	
	if is_in_group("Player"):
		target_group = "Enemy"
	elif is_in_group("Enemy"):
		target_group = "Player"
	#print(target_group)
	
	damage = get_parent().damage
	
	get_child(0).disabled = true

func _on_area_entered(area):
	#print("hit")
	if area.get_parent().is_in_group(target_group):
		area.attacked(damage)
		get_parent().queue_free()
