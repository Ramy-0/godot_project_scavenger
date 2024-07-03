extends CharacterBody2D

class_name PlayerClass

@export var base_health:float
@export var base_speed:float

var speed_mult:float = 1.0
var health_mult:float = 1.0
var health:float

@export var collisionBox : CollisionShape2D
@export var sprite : AnimatedSprite2D
@export var camera : Camera2D
@export var weaponBelt : WeaponBelt
@export var hurtBox : HurtBox
@export var healthgui : HealthGUI


func _ready():
	health = base_health

func _physics_process(delta):
	#movement:
	var direction = Input.get_vector("kb_left", "kb_right", "kb_up", "kb_down")
	velocity = direction * base_speed * speed_mult
	
	move_and_slide()

