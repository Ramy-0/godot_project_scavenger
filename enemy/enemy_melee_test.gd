extends CharacterBody2D

@export var health: float = 100.0
@export var dmg: float = 12.0
@export var speed: float = 250.0
@export var attack_speed: float = 0.1
@export var attack_delay: float = 0.1

@export var player_target: Node2D
@onready var nav_agent:= $NavigationAgent2D as NavigationAgent2D

@onready var atk_delay_timer = $Attack_Delay_Timer
@onready var atk_speed_timer = $Attack_Speed_Timer

func _ready():
	atk_delay_timer.wait_time = attack_delay
	atk_speed_timer.wait_time = attack_speed

func _physics_process(delta):
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()

func make_path() -> void:
	if player_target != null:
		nav_agent.target_position = player_target.global_position

func bite(player):
	pass

func _on_activate_area_body_entered(body):
	if body.is_in_group("Player"):
		print("Player spoted")
		if player_target == null:
			player_target = body
			print(player_target)


func _on_attack_area_body_entered(body):
	if body.is_in_group("Player"):
		print("bite")
		atk_delay_timer.start()


func _on_nav_age_ref_timer_timeout():
	make_path()


func _on_attack_delay_timer_timeout():
	bite(player_target)
