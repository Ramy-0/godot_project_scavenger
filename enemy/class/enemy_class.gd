extends CharacterBody2D

class_name EnemyClass

@export_group("Stats")
@export var base_health : float
@export var base_speed : float
@export var damage : float
@export var spawn_price : int
@export var spawn_weight : float
@export var coin_reward : int

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

var coin = preload("res://item/coin.tscn")

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

func navigate_to_location(pos : Vector2):
	var dir = to_local(pos).normalized()
	velocity = dir * nav_speed
	#print(global_position.distance_to(pos))
	if global_position.distance_to(pos) > 10.0:
		move_and_slide()

func look_at_path():
	sprite.look_at(navAgent.get_next_path_position())
	sprite.rotate(deg_to_rad(90))
	if hitBoxStatic != null:
		hitBoxStatic.rotation = sprite.rotation

func look_at_target(_target):
	sprite.look_at(_target.position)
	sprite.rotate(deg_to_rad(90))
	if hitBoxStatic != null:
		hitBoxStatic.rotation = sprite.rotation

func look_at_point(point:Vector2):
	sprite.look_at(point)
	sprite.rotate(deg_to_rad(90))
	if hitBoxStatic != null:
		hitBoxStatic.rotation = sprite.rotation

func attacked(_damage):
	health = health - _damage
	hurt_mark()
	if health <= 0 :
		die()

func die():
	var c = coin.instantiate()
	c.amount = coin_reward
	get_parent().add_child(c)
	c.global_position = global_position
	queue_free()

func hurt_mark():
	sprite.self_modulate = Color(50,50,50,50)
	await get_tree().create_timer(0.05).timeout
	sprite.self_modulate = Color("white")
