extends Node2D

#weapon stats:
@export var dmg: float = 25.0
@export var reload_speed: float = 0.2
@export var shooting_speed: float = 0.05

#weapon status:
var active: bool = false

#weapon children nodes
@onready var reloadTimer = $ReloadTimer
@onready var shootingTimer = $ShootingTimer

func _ready():
	#set the timers:
	reloadTimer.wait_time = reload_speed
	shootingTimer.wait_time = shooting_speed

func _process(delta):
	if active:
		#handle shooting input
		if Input.is_action_just_pressed("m_1"):
			shoot()

func _physics_process(delta):
	#rotates the weapon to look at the mouse
	look_at(get_global_mouse_position())

func shoot():
	print("bang")

func set_active(state: bool):
	active = state
