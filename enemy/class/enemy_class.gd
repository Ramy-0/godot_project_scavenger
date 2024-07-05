extends CharacterBody2D

class_name EnemyClass

@export var base_health : float
@export var base_speed : float
@export var damage : float

@export var hurtBox : HurtBoxV2
@export var hitBox : HitBoxV2
@export var hitBoxColl : CollisionShape2D
@export var sprite : AnimatedSprite2D
@export var navAgent : NavigationAgent2D
@export var stateChart : StateChart

@export var target : CharacterBody2D


var health : float
var speed : float
var nav_speed : float

var moving : bool = true

func update_variables():
	health = base_health
	speed = base_speed
	nav_speed = speed
	
	navAgent.target = target

func navigate_to(target):
	if navAgent != null and navAgent.target != null and moving:
		var dir = to_local(navAgent.get_next_path_position()).normalized()
		velocity = dir * nav_speed
		move_and_slide()

func look_at_path():
	sprite.look_at(navAgent.get_next_path_position())
	sprite.rotate(deg_to_rad(90))
	hitBox.rotation = sprite.rotation

func look_at_target(target):
	sprite.look_at(target.position)
	sprite.rotate(deg_to_rad(90))
	hitBox.rotation = sprite.rotation

func attacked(damage):
	health = health - damage
	if health <= 0 :
		queue_free()
