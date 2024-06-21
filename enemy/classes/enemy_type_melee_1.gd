extends CharacterBody2D

class_name EnemyTypeMelee1

@export var target: PlayerV1		#change to player class

#stats
@export var health : float
@export var damage : float
@export var speed : float

#subnodes
@export var stateChart : Node2D
@export var navAgent : NavigationAgent2D
@export var attack : Node2D
@export var collisionBox : CollisionShape2D
@export var animSprite : AnimatedSprite2D

func _physics_process(delta):
	if navAgent != null and navAgent.target != null:
		var dir = to_local(navAgent.get_next_path_position()).normalized()
		velocity = dir * speed
		move_and_slide()

func hurt(dmg):
	print("owwie")
