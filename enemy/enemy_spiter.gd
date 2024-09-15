extends EnemyClass

@export var aiming_delay: float
@export var aiming_distance: float
@export var proj_delay: float
@export var proj_lifespam: float
@export var slowing_mult: float
@export var player_can_move: bool
@export var projectile: PackedScene
@export var attack_delay: float

var base_num_zigzags : int = 4
var num_zigzags : int
var zigzag_pos : Vector2
var aiming_pos : Vector2

func _ready() -> void:
	$AttackArea/CollisionShape2D.shape.radius = aiming_distance
	update_variables()
	$DelayTimer.wait_time = attack_delay


#STATES SIGNALS
func _on_chasing_c_state_state_entered() -> void:
	if $AttackArea.overlaps_body(target):
		await $DelayTimer.timeout
		stateChart.send_event("player_near")

func _on_straight_a_state_state_physics_processing(delta: float) -> void:
	navigate_to(target)
	look_at_path()

func _on_zigzag_a_state_state_entered() -> void:
	$ZigzagPos.show()
	num_zigzags = base_num_zigzags
	#zigzag_pos = global_position+(global_position-target.global_position).rotated(randf_range(-PI/6, PI/6)*20)
	zigzag_pos = global_position-(global_position-target.global_position).normalized().rotated(randf_range(-PI/4, PI/4))*200
	#print(zigzag_pos)
	#print(position)

func _on_zigzag_a_state_state_physics_processing(delta: float) -> void:
	#print(position)
	$ZigzagPos.global_position = zigzag_pos
	navigate_to_location($ZigzagPos.global_position)
	look_at_point(zigzag_pos)
	#print(global_position.distance_to($ZigzagPos.global_position) )
	if global_position.distance_to($ZigzagPos.global_position) <= 10.0:
		#print("zig")
		#zigzag_pos = global_position+(global_position-target.global_position).rotated(randf_range(-PI/6, PI/6)*20)
		zigzag_pos = global_position-(global_position-target.global_position).normalized().rotated(randf_range(-PI/5, PI/5))*200
		#print(zigzag_pos)
		#print(position)
		#print(global_position)
		num_zigzags -= 1
		if num_zigzags == 0:
			stateChart.send_event("straight")
			$ZigzagPos.hide()

func _on_aiming_a_state_state_entered() -> void:
	$ProjPos.show()

func _on_aiming_a_state_state_processing(delta: float) -> void:
	aiming_pos = target.global_position + target.velocity * proj_delay
	$ProjPos.global_position = aiming_pos
	await get_tree().create_timer(aiming_delay).timeout
	stateChart.send_event("shoot")

func _on_shooting_a_state_state_entered() -> void:
	var proj = projectile.instantiate()
	proj.init(global_position, aiming_pos, proj_delay, proj_lifespam, 0, slowing_mult, player_can_move)
	MyFuncs.get_fst_parent_in(self, "World").add_child(proj)
	stateChart.send_event("attack_finished")
	$DelayTimer.start()


#AREA SIGNALS
func _on_chase_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		target = body
		stateChart.send_event("player_spotted")

func _on_attack_area_body_entered(body: Node2D) -> void:
	if $DelayTimer.time_left > 0:
		await $DelayTimer.timeout
		stateChart.send_event("player_near")
	else:
		stateChart.send_event("player_near")

func _on_enemy_hurt_box_area_entered(area: Area2D) -> void:
	if randi_range(0,10) == 9:
		stateChart.send_event("zigzag")
