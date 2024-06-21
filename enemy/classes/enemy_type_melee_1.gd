extends CharacterBody2D

class_name EnemyTypeMelee1

@export var target: PlayerV1		#change to player class

#stats
@export var base_health : float
@export var base_damage : float
@export var base_speed : float

var health: float
var damage: float
var speed: float
var moving:bool = true

#subnodes
@export var stateChart : Node2D
@export var navAgent : NavigationAgent2D
@export var attack : Node2D
@export var collisionBox : CollisionShape2D
@export var animSprite : AnimatedSprite2D

func _ready():
	health = base_health
	damage = base_damage
	speed = base_speed

func _physics_process(delta):
	if navAgent != null and navAgent.target != null and moving:
		var dir = to_local(navAgent.get_next_path_position()).normalized()
		velocity = dir * speed
		move_and_slide()

func hurt(dmg):
	print("owwie")
