extends EnemyClass

@export var pre_charge_delay : float
@export var charge_delay : float
@export var grace_delay : float
@export var charge_speed_multiplier : float

@onready var preChargeT : Timer = $Pre_Charge_Timer
@onready var chargeT : Timer = $Charge_Timer
@onready var graceT : Timer = $Grace_Timer

var charge_target_vector : Vector2

func _ready():
	preChargeT.wait_time = pre_charge_delay
	chargeT.wait_time = charge_delay
	graceT.wait_time = grace_delay
	update_variables()

func _process(delta: float) -> void:
	$HealthBar.max_value = max_health
	$HealthBar.value = health
	$HealthLabel.text = str(health) + '/' + str(max_health)

#AREA SIGNALS
func _on_chasing_area_body_entered(body):
	if body.is_in_group("Player") and target == null:
		target = body
		stateChart.send_event("player_in_sight")

func _on_charge_area_body_entered(body):
	if body.is_in_group("Player"):
		stateChart.send_event("player_in_charge_range")
	

#STATE CHART SIGNALS
func _on_chasing_state_state_entered() -> void:
	if $Charge_Area.overlaps_body(target):
		stateChart.send_event("player_in_charge_range")
	
func _on_chasing_state_state_physics_processing(delta):
	navigate_to(target)
	look_at_path()

func _on_aiming_state_state_entered():
	preChargeT.start()

func _on_aiming_state_state_physics_processing(delta):
	look_at_target(target)

func _on_grace_state_state_entered():
	charge_target_vector = target.global_position
	graceT.start()

func _on_charging_state_state_entered():
	chargeT.start()
	hitBoxStatic.activate(1.0)
	set_collision_mask_value(3, 0)

func _on_charging_state_state_physics_processing(delta):
	navigate_to_location(charge_target_vector, charge_speed_multiplier)

func _on_charging_state_state_exited():
	hitBoxStatic.deactivate()
	set_collision_mask_value(3, 1)

#TIMER SIGNAL
func _on_pre_charge_timer_timeout():
	stateChart.send_event("aim_finished")

func _on_charge_timer_timeout():
	stateChart.send_event("charge_finnished")

func _on_grace_timer_timeout():
	stateChart.send_event("grace_ended")


#HURTBOX SIGNAL
func _on_enemy_hurt_box_hurtbox_attacked() -> void:
	$Blood_Particles.emitting = true
