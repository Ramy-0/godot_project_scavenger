extends Node2D



#weapon stats:
@export var bullet_dmg: float = 25.0
@export var bullet_speed: float = 1500.0

@export var mag_size: int = 16
@export var reload_speed: float = 0.5
@export var shooting_speed: float = 0.1

var mag: int

#weapon status:
var active: bool = false

#weapon children nodes
@onready var reloadTimer = $ReloadTimer
@onready var shootingTimer = $ShootingTimer

#preloads:
@export var bullet = preload("res://weapons/bullet_basic.tscn")

#other
var world

func _ready():
	#set the timers:
	reloadTimer.wait_time = reload_speed
	shootingTimer.wait_time = shooting_speed
	
	mag = mag_size
	world = MyFuncs.get_fst_parent_in(self, "World")
	print(world)

func _process(delta):
	if active:
		#handle shooting input
		if Input.is_action_just_pressed("m_1"):
			shoot()
		
		if mag < mag_size and reloadTimer.is_stopped():
			reload()

func _physics_process(delta):
	#rotates the weapon to look at the mouse
	look_at(get_global_mouse_position())

func shoot():
	
	if shootingTimer.is_stopped() and mag > 0:
		mag = mag - 1
		var bullet_inst = bullet.instantiate()
		bullet_inst.init(get_parent(), bullet_dmg, bullet_speed, self.global_position, self.global_rotation)
		
		world.add_child(bullet_inst)
		
		shootingTimer.start()

func set_active(state: bool):
	active = state

func reload():
	reloadTimer.start()
	

func _on_reload_timer_timeout():
	mag = mag + 1
	if mag < mag_size:
		reload()


func _on_shooting_timer_timeout():
	print("ready to shoot")
