extends WeaponClass

@export var active : bool
@export var damage : int
@export var bullet_speed : float
@export var bullet_lifetime : float
@export var mag_size : int
@export var fire_delay : float
@export var releod_delay : float
@export var pre_releod_delay : float

var mag: int

@export var bullet : PackedScene

@onready var fire_timer = $Fire_Timer
@onready var reload_timer = $Reload_Timer
@onready var prereload_timer = $Pre_Reload_Timer

func _ready():
	$Pivot.rotate(PI)
	world = MyFuncs.get_fst_parent_in(self, "World")
	#print(world)
	
	mag = mag_size
	
	fire_timer.wait_time = fire_delay
	reload_timer.wait_time = releod_delay
	prereload_timer.wait_time = pre_releod_delay

func _process(delta):
	$Pivot.look_at(get_global_mouse_position())
	$Pivot.rotate(PI)
	if $Pivot.rotation > (2 * PI) :
		$Pivot.rotate(- 2 * PI)
	elif $Pivot.rotation < 0.0:
		$Pivot.rotate(2 * PI)
	$Pivot/Sprite2D.flip_v = ($Pivot.rotation > 0.5 * PI and $Pivot.rotation < 1.5 * PI )
	
	if Input.is_action_just_pressed("m_1"):
		if not prereload_timer.paused:
			prereload_timer.start()
		if mag > 0:
			
			shoot()
	
	$Mag_Label.text = str(mag)
	$Fire_Delay_Label.text = str(fire_timer.time_left)
	$Reload_Delay_Label.text = str(reload_timer.time_left)
	$PreReload_Delay_Label.text = str(prereload_timer.time_left)

func shoot():
	mag = mag - 1
	reload_timer.stop()
	if prereload_timer.wait_time > 0:
		prereload_timer.start()
	var bullet_inst = bullet.instantiate()
	bullet_inst.init(get_parent().get_parent(), damage, bullet_speed, bullet_lifetime, $Pivot.global_position, $Pivot.global_rotation + PI)
	world.add_child(bullet_inst)
	fire_timer.start()

func _on_fire_timer_timeout():
	if Input.is_action_pressed("m_1") and mag > 0:
		shoot()
	else:
		prereload_timer.start()

func _on_pre_reload_timer_timeout():
	reload_timer.start()

func _on_reload_timer_timeout():
	mag = mag + 1
	if mag < mag_size:
		reload_timer.start()
		
