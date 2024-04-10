extends Node2D

@export var active_r: int = 20
@export var attack_r: int = 10

var parent: Node2D

@onready var active_area = $Active_Area
@onready var active_collision = $Active_Area/CollisionShape2D
@onready var attack_area = $Attack_Area
@onready var attack_collision = $Attack_Area/CollisionShape2D

func _ready():
	active_collision.radius = active_r
	attack_collision.radius = attack_r
	parent = get_parent()


func _on_active_area_body_entered(body):
	if body.is_in_group("Player") and parent.player_target == null:
		parent.player_target = body


func _on_attack_area_body_entered(body):
	if body.is_in_group("Player"):
		if parent.has_method("attack"):
			parent.attack(body)
