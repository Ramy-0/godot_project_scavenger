extends CharacterBody2D

#CHILD NODES
@onready var navAgent = $NavigationAgent2D
@onready var stateChart = $StateChart
@onready var atkPreT = $Attack_Pre_Timer
@onready var atkPostT = $Attack_Post_Timer
@onready var navRefT = $Nav_Refresh_Timer
@onready var hitBox = $HitBox
@onready var hitBoxColl = $HitBox/CollisionShape2D

#STATS VAR
@export var base_speed:float = 250.0
@export var base_damage:float = 25.0
@export var base_health:int = 250
@export var attack_pre_time:float = 0.3
@export var attack_post_time:float = 0.3
@export var target:CharacterBody2D

var nav_speed:float

func _ready() -> void:
	atkPreT.wait_time = attack_pre_time
	atkPostT.wait_time = attack_post_time
	nav_speed = base_speed

func _physics_process(delta):
	pass


#METHODS
func make_nav_path() -> void:
	if target != null:
		navAgent.target_position = target.global_position


#AREA SIGNALS
func _on_chase_area_body_entered(body):
	if body.is_in_group("Player") and target == null:
		target = body
		stateChart.send_event("player_in_sight")

func _on_attack_area_body_entered(body):
	if body.is_in_group("Player") and body == target:
		stateChart.send_event("player_in_attack_range")


#STATE CHARTS SIGNALS
func _on_chasing_state_state_entered():
	navRefT.start()
	if $Attack_Area.overlaps_body(target):
		stateChart.send_event("player_in_attack_range")

func _on_chasing_state_state_physics_processing(delta):
	var dir = to_local(navAgent.get_next_path_position()).normalized()
	velocity = dir * nav_speed
	move_and_slide()
	$Sprite2D.look_at(navAgent.get_next_path_position())
	$Sprite2D.rotate(deg_to_rad(90))
	$HitBox.rotation = $Sprite2D.rotation

func _on_attacking_state_state_entered():
	navRefT.stop()
	atkPreT.start()


#TIMERS SIGNALS
func _on_nav_refresh_timer_timeout():
	make_nav_path()

func _on_attack_pre_timer_timeout():
	hitBoxColl.disabled = false
	atkPostT.start()
	await get_tree().create_timer(0.05).timeout
	hitBoxColl.disabled = true

func _on_attack_post_timer_timeout():
	stateChart.send_event("attack_finished")


#HITBOX SIGNAL
func _on_hit_box_body_entered(body):
	if body.is_in_group("Player"):
		if body.has_method("hit"):
			body.hit(base_damage)
