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


#FUNCTIONS
func activate():
	collShape.disabled = false

func deactivate():
	collShape.disabled = true
	timer.stop()

func activate_for(delay:float):
	collShape.disabled = false
	await get_tree().create_timer(delay).timeout
	collShape.disabled = true

func activate_every(delay:float):
	timer.wait_time = delay
	timer.start()


#SIGNALS
func _on_area_entered(area):
	#print("hit sth")
	if area.get_parent().is_in_group("Player"):
		#print("area attacked")
		area.attacked(damage)

func _on_timer_timeout() -> void:
	collShape.disabled = false
	await  get_tree().create_timer(0.05).timeout
	collShape.disabled = true
