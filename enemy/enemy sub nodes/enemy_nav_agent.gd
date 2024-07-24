extends NavigationAgent2D

@export var target : Node2D
@export var pathUpdateTime : float = 0.2

@onready var updateTimer = $Update_Timer

func _ready():
	updateTimer.wait_time = pathUpdateTime
	updateTimer.stop()

func _physics_process(delta):
	if target != null and updateTimer.is_stopped():
		updateTimer.start()
	
	if get_parent().target != null and target == null:
		target = get_parent().target

func update_path():
	if target != null:
		target_position = target.global_position

func _on_update_timer_timeout():
	update_path()


func _on_velocity_computed(safe_velocity: Vector2) -> void:
	pass # Replace with function body.
