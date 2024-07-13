extends CharacterBody2D

class_name EnemyClass

@export_group("Stats")
@export var base_health : float
@export var base_speed : float
@export var damage : float
@export var spawn_price : int

@export_group("Sub Nodes")
@export var hurtBox : EnemyHurtbox
@export var hitBoxStatic : EnemyHitboxStatic
@export var hitBoxColl : CollisionShape2D
@export var sprite : AnimatedSprite2D
@export var navAgent : NavigationAgent2D
@export var stateChart : StateChart
@export var statusHandler : StatusHandler

@export_group("Target")
@export var target : CharacterBody2D


var max_health : float
var health : float
var speed : float
var nav_speed : float

var moving : bool = true

func update_variables():
	max_health = base_health
	health = max_health
	speed = base_speed
	nav_speed = speed
	
	navAgent.target = target

func navigate_to(_target):
	if navAgent != null and navAgent.target != null and moving:
		var dir = to_local(navAgent.get_next_path_position()).normalized()
		velocity = dir * nav_speed
		move_and_slide()

func look_at_path():
	sprite.look_at(navAgent.get_next_path_position())
	sprite.rotate(deg_to_rad(90))
	hitBoxStatic.rotation = sprite.rotation

func look_at_target(target):
	sprite.look_at(target.position)
	sprite.rotate(deg_to_rad(90))
	hitBoxStatic.rotation = sprite.rotation

func attacked(damage):
	health = health - damage
	hurt_mark()
	if health <= 0 :
		die()

func die():
	queue_free()

func hurt_mark():
	sprite.self_modulate = Color(50,50,50,50)
	await get_tree().create_timer(0.05).timeout
	sprite.self_modulate = Color("white")
