extends Area2D

class_name EnemyHitboxStatic

@export var damage : int

@export var collShape : CollisionShape2D

func _ready():
	damage = get_parent().damage
	collShape = get_child(0)
	collShape.disabled = true

func activate(delay:float = 0.1):
	collShape.disabled = false
	await get_tree().create_timer(0.05).timeout
	collShape.disabled = true

func _on_area_entered(area):
	#print("hit sth")
	if area.get_parent().is_in_group("Player"):
		#print("area attacked")
		area.attacked(damage)
