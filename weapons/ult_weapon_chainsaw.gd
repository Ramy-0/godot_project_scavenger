extends UltWeaponClass

@export var max_fuel : float = 100.0
@export var fuel : float = 100.0
@export var damage : int = 50
@export var revUpSpeed1 : float = 0.2		#every x sec the rev increases by 1
@export var revUpSpeed2: float = 0.2
@export var maxRev1 : float = 8.0			#every 1/x sec the chainsaw damages and
@export var maxRev2 : float = 12.0			# the fuel decreases by 1
@export var fuelRecov : float = 5.0			#every 1 sec the fuel increase by x

var rps : float = 0
var stateTimer : float = 0


@onready var stateChart = $StateChart

func _ready() -> void:
	if active:
		stateChart.send_event("use")
	else:
		stateChart.send_event("to_back")

func _physics_process(delta: float) -> void:
	$Pivot.look_at(get_global_mouse_position())
	$Pivot.rotate(PI)
	if $Pivot.rotation > (2 * PI) :
		$Pivot.rotate(- 2 * PI)
	elif $Pivot.rotation < 0.0:
		$Pivot.rotate(2 * PI)
	$Pivot/AnimatedSprite2D.flip_v = ($Pivot.rotation > 0.5 * PI and $Pivot.rotation < 1.5 * PI )

func set_as_active():
	#to overwrite the built in functionx
	stateChart.send_event("use")

func set_as_inactive():
	#to overwrite the built in function
	stateChart.send_event("to_back")

func turn_hitbox_on(dmg):
	$Pivot/Player_HitBox_Static.activate_for(0.1)

#HITBOX SIGNALS
func _on_player_hit_box_static_area_entered(area: Area2D) -> void:
	$Pivot/CPUParticles2D.emitting = true


#STATE SIGNALS
func _on_back_a_state_state_entered() -> void:
	hide()
	$CanvasLayer.hide()

func _on_back_a_state_state_processing(delta: float) -> void:
	fuel += delta*4

func _on_in_use_c_state_state_entered() -> void:
	show()
	$CanvasLayer.show()
	$CanvasLayer/HBoxContainer/VBoxContainer/FuelContainer/ProgressBar.max_value = max_fuel

func _on_in_use_c_state_state_processing(delta: float) -> void:
	$CanvasLayer/HBoxContainer/VBoxContainer/FuelContainer/ProgressBar.value = fuel
	$CanvasLayer/HBoxContainer/VBoxContainer/RevContainer/Label2.text = str(rps)
	
	
	#Place holder logic
	#if Input.is_mouse_button_pressed(1): # Left click pressed
		#$Pivot/Player_HitBox_Static.activate_every(0.05)
	#elif not Input.is_mouse_button_pressed( 1 ): # Left click NOT pressed
		#$Pivot/Player_HitBox_Static.deactivate()
	
	#REAL logic
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		stateChart.send_event("mouse_1_pressed")
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		stateChart.send_event("mouse_2_pressed")

func _on_attack_1c_state_state_processing(delta: float) -> void:
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		stateChart.send_event("stop")
	fuel -= rps*delta

func _on_rev_up_1a_state_state_entered() -> void:
	stateTimer = 0

func _on_rev_up_1a_state_state_processing(delta: float) -> void:
	stateTimer += delta
	if stateTimer > revUpSpeed1:
		rps += 1
		stateTimer = 0
		$Pivot/Player_HitBox_Static.activate_for(0.05)
	if rps >= maxRev1:
		rps = maxRev1
		stateChart.send_event("maxrev1_reached")

func _on_max_rev_1a_state_state_entered() -> void:
	$Pivot/Player_HitBox_Static.deactivate()
	$Pivot/Player_HitBox_Static.activate_every(1/maxRev1)

func _on_max_rev_1a_state_state_exited() -> void:
	await $Pivot/Player_HitBox_Static.timer.timeout
	$Pivot/Player_HitBox_Static.deactivate()

func _on_idle_a_state_state_entered() -> void:
	stateTimer = 0

func _on_idle_a_state_state_processing(delta: float) -> void:
	if rps > 0:
		stateTimer += delta
		if stateTimer > 0.4:
			rps -= 1
			stateTimer = 0
		fuel -= rps*delta*0.4
	fuel -= delta

func _on_attack_2c_state_state_processing(delta: float) -> void:
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		stateChart.send_event("stop")

func _on_rev_up_2a_state_state_entered() -> void:
	stateTimer = 0

func _on_rev_up_2a_state_state_processing(delta: float) -> void:
	stateTimer += delta
	if stateTimer > revUpSpeed2:
		rps += 1
		stateTimer = 0
	if rps >= maxRev2:
		rps = maxRev2
		stateChart.send_event("maxrev2_reached")
