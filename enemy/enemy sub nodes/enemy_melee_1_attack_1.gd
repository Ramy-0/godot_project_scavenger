extends Node2D

var active:bool = false

var target:CharacterBody2D
var damage:float

@export var range:float
@export var pre_delay:float = 0.5
@export var post_delay:float = 0.5
@export var dmg:int = 25

@onready var pre_t = $Pre_Timer
@onready var post_t = $Post_Timer

func _ready():
	pre_t.wait_time = pre_delay
	post_t.wait_time = post_delay

#func attack(target, dmg):
	#if active == false:
		#active = true
		#await pre_t.timeout
		#print("pre timer finished")
		#if self.global_position.distance_to(target.global_position) <= range:
			#if target.has_method("hurt"):
				#target.hurt(dmg)
		#await post_t.timeout
		#print("post timer finished")
		#active = false
		#print("attack finished")

func attack(targ, dmg):
	if not active:
		target = targ
		damage = dmg
		active = true
		pre_t.start()


func _on_pre_timer_timeout():
	print("pre timer timeout")
	if self.global_position.distance_to(target.global_position) <= range:
		if target.has_method("hurt"):
			target.hurt(damage)
	post_t.start()



func _on_post_timer_timeout():
	print("post timer timeout")
	active = false
