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
	#$HealthBar.max_value = max_health
	#$HealthBar.value = health
	#$HealthLabel.text = str(health) + '/' + str(max_health)
	pass


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
	charge_target_vector = target.global_position + (
		target.global_position-self.global_position).normalized()*250
	#draw_circle(charge_target_vector, 20, Color.ORANGE, false)
	graceT.start()

func _on_charging_state_state_entered():
	chargeT.start()
	hitBoxStatic.activate(1.0)
	set_collision_mask_value(3, 0)
	$Pushing_Area.monitoring = true
	nav_speed = speed * charge_speed_multiplier
	var speed_tween = create_tween()
	speed_tween.tween_property(self, "nav_speed", speed, charge_delay).set_trans(Tween.TRANS_SINE)

func _on_charging_state_state_physics_processing(delta):
	navigate_to_location(charge_target_vector)

func _on_charging_state_state_exited():
	hitBoxStatic.deactivate()
	set_collision_mask_value(3, 1)
	$Pushing_Area.monitoring = false

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


func _on_pushing_area_body_entered(body: Node2D) -> void:
	if body != self:
		print("pushing ", body)
		var push_pos = (body.global_position - global_position).normalized() * 200
		var push = create_tween()
		push.tween_property(
			body, "global_position",
			body.global_position + push_pos, 
			0.2
		 ).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
