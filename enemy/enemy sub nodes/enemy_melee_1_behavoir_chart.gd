extends Node2D

@onready var parent:Node = get_parent()
@onready var obs_r = $Observation_Range
@onready var atk_r = $Attack_Range
@onready var sc = $StateChart

@export var obs_rad:float = 50
@export var atk_rad:float = 25

var target:CharacterBody2D

func _ready():
	$Observation_Range/CollisionShape2D.shape.radius = obs_rad
	$Attack_Range/CollisionShape2D.shape.radius = atk_rad
	

func _process(delta):
	pass

func _on_observation_range_body_entered(body):
	if body.is_in_group("Player"):
		print("player spoted")
		target = body
		$StateChart.send_event("Player_Seen")

func _on_attack_range_body_entered(body):
	if body.is_in_group("Player"):
		print("player near")
		target = body
		$StateChart.send_event("Player_Near")

func _on_chasing_state_state_entered():
	parent.target = target
	if atk_r.overlaps_body(target):
		$StateChart.send_event("Player_Near")

func _on_attacking_state_state_entered():
	print(parent.attack.has_method("attack"))
	parent.attack.attack(target, parent.damage)
	parent.moving = false
	await parent.attack.post_t.timeout
	print("finished")
	parent.moving = true
	$StateChart.send_event("Attack_Finished")
