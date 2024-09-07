extends Node2D

@export var speed : float = 800
#@export var duration : float = 5
@export var slow_mult : float = 0.4
@export var can_use_mov_ab : bool = false

#var init_pos : Vector2
var final_pos : Vector2
#state 0 shooting thru the air state 1 on the ground
var state : int = 0

func _ready() -> void:
	state = 0
	$AnimatedSprite2D.frame = 0

func _process(delta: float) -> void:
	var movTween = create_tween()
	movTween.tween_property(
		self, "global_position", final_pos, position.distance_to(final_pos)/speed
	)
	await movTween.finished
	on_ground()

func init(init_pos:Vector2, destination_p:Vector2,delay_p:float, duration_p:float,
 speed_p:float, slow_p:float, move_p:bool) -> void:
	#init_pos = position
	global_position = init_pos
	final_pos = destination_p
	$DurationTimer.wait_time = duration_p
	slow_mult = slow_p
	can_use_mov_ab = move_p
	
	#var movTween = create_tween()
	#movTween.tween_property(
		#self, "position", final_pos, position.distance_to(final_pos)/speed
	#)
	#await movTween.finished
	#on_ground()

func on_ground() -> void:
	if state == 0:
		print("open")
		state = 1
		$AnimatedSprite2D.frame = 1
		$State0Area.monitoring = false
		$State1Area.monitoring = true
		$DurationTimer.start()

func _on_duration_timer_timeout() -> void:
	queue_free()


func _on_state_0_area_body_entered(body: Node2D) -> void:
	print("hit sth")
	if body.is_in_group("Player"):
		on_ground()

func _on_state_1_area_body_entered(body: Node2D) -> void:
	body.speed_mult *= slow_mult

func _on_state_1_area_body_exited(body: Node2D) -> void:
	body.speed_mult /= slow_mult
