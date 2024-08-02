extends EnemyClass

@export var pre_atk_delay : float
@export var post_atk_delay : float

@onready var atkPreT = $Pre_Atk_Timer
@onready var atkPostT = $Post_Atk_Timer

func _ready():
	atkPreT.wait_time = pre_atk_delay
	atkPostT.wait_time = post_atk_delay
	update_variables()

func _process(delta: float) -> void:
	$HealthBar.max_value = max_health
	$HealthBar.value = health
	$HealthLabel.text = str(health) + '/' + str(max_health)


#CLASS FUNCTIONS
func die():
	queue_free()

#AREA SIGNALS
func _on_chasing_area_body_entered(body):
	#print("see u")
	if body.is_in_group("Player") and target == null:
		target = body
		stateChart.send_event("player_in_sight")

func _on_attacking_area_body_entered(body):
	if body.is_in_group("Player") and body == target:
		stateChart.send_event("player_in_attack_range")


#STATE CHARTS SIGNALS
func _on_chasing_a_state_state_entered():
	#navRefT.start()
	if $Attacking_Area.overlaps_body(target):
		stateChart.send_event("player_in_attack_range")

func _on_chasing_a_state_state_physics_processing(delta):
	navigate_to(target)
	look_at_path()

func _on_attacking_a_state_state_entered():
	#navRefT.stop()
	look_at_target(target)
	atkPreT.start()


#TIMERS SIGNALS
func _on_pre_atk_timer_timeout():
	atkPostT.start()
	hitBoxStatic.activate()

func _on_post_atk_timer_timeout():
	stateChart.send_event("attack_finished")


#HURTBOX SIGNALS
func _on_enemy_hurt_box_area_entered(area):
	$Blood_Particles.emitting = true
