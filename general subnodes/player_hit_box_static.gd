extends Area2D

class_name PlayerHitboxStatic

@export var damage : int
var activated : bool = false 

@export var collShape : CollisionShape2D
@export var parent : Node2D
@onready var timer = $Timer

func _ready():
	damage = parent.damage
	collShape.disabled = true

#func _process(delta: float) -> void:
	#print(activated)

#FUNCTIONS
func activate():
	activated = true
	collShape.disabled = false

func deactivate():
	if activated:
		collShape.disabled = true
		timer.stop()
		activated = false

func activate_for(delay:float):
	activated = true
	collShape.disabled = false
	await get_tree().create_timer(delay).timeout
	collShape.disabled = true
	activated = false

func activate_every(delay:float):
	if timer.is_stopped():
		timer.wait_time = delay
	else:
		await timer.timeout
		timer.wait_time = delay
	if not activated:
		activated = true
		timer.start()


#SIGNALS
func _on_area_entered(area):
	#print("hit sth")
	if area.get_parent().is_in_group("Enemy"):
		#print("area attacked")
		area.attacked(damage)

func _on_timer_timeout() -> void:
	collShape.disabled = false
	activated = true
	await  get_tree().create_timer(0.05).timeout
	collShape.disabled = true
	activated = false
