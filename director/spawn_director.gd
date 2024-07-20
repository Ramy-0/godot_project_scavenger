extends Node2D

@export var credits: float = 15
@export var credit_gain_delay : float = 1.0
@export var credit_gain : int = 5
@export var player : CharacterBody2D
@export var world : Node2D

@export var enemy_pool : Array = [
	[load("res://enemy/enemy_basic.tscn"), 5, 100],
	[load("res://enemy/enemy_charger.tscn"), 15, 25]
]

func _ready():
	world = get_parent()
	player = MyFuncs.get_children_in_group(world, "Player")[0]
	print(world)
	print(player)
	
	print(enemy_pool[0][0].spawn_price)

func _process(delta):
	pass

func _on_timer_timeout():
	credits += credit_gain
	print(credits)
