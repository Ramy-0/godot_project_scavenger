extends Node2D

@export var credits: float = 15
@export var credit_gain_delay : float = 1.0
@export var player : CharacterBody2D
@export var world : Node2D

func _ready():
	world = get_parent()
	player = MyFuncs.get_children_in_group(world, "Player")[0]
	print(world)
	print(player)

func _process(delta):
	pass
