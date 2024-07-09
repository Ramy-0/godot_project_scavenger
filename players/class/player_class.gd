extends CharacterBody2D

class_name PlayerClass

@export var base_health:float
@export var base_speed:float
@export var preHealingDelay:float = 2
@export var healingDelay:float = 0.5

var speed_mult:float = 1.0
var health_mult:float = 1.0
var health:float
var max_health:float

@export var collisionBox : CollisionShape2D
@export var sprite : AnimatedSprite2D
@export var camera : Camera2D
@export var weaponBelt : WeaponBelt
@export var hurtBox : PlayerHurtbox
@export var healthgui : HealthGUI
@export var movementAbility : MovementClass
@export var healTimer : Timer
@export var preHealTimer : Timer


func _ready():
	max_health = base_health
	health = max_health
	
	preHealTimer.one_shot = true
	healTimer.one_shot = true
	preHealTimer.wait_time = preHealingDelay
	healTimer.wait_time = healingDelay
	preHealTimer.timeout.connect(_on_preHealTimer_Timeout)
	healTimer.timeout.connect(_on_healTimer_Timeout)

func _physics_process(delta):
	#movement:
	var direction = Input.get_vector("kb_left", "kb_right", "kb_up", "kb_down")
	velocity = direction * base_speed * speed_mult
	
	move_and_slide()
	
	#healing
	if health < max_health and preHealTimer.is_stopped() and healTimer.is_stopped():
		preHealTimer.start()

func attacked(damage):
	health = health - damage
	preHealTimer.start()
	if healTimer.time_left > 0:
		healTimer.stop()

func _on_preHealTimer_Timeout():
	healTimer.start()

func _on_healTimer_Timeout():
	health += max_health * 0.1
	if health < max_health:
		healTimer.start()
	else:
		health = max_health
