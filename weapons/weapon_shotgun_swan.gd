extends WeaponClass


@export var damage : int
@export var pellet_speed : float
@export var pellet_lifetime : float
@export var mag_size : int
@export var fire_delay : float
@export var releod_delay : float
@export var spread : float
@export var pre_releod_delay : float
@export var push_distance : float
@export var pellets_per_shell : int
@export var debug_gui : bool = false

var mag: int


@export var pellet : PackedScene

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
	
	if debug_gui :
		$CanvasLayer/HBoxContainer/VBoxContainer/Fire_Delay_Label.show() 
		$CanvasLayer/HBoxContainer/VBoxContainer/Reload_Delay_Label.show() 
		$CanvasLayer/HBoxContainer/VBoxContainer/PreReload_Delay_Label.show()
	else:
		$CanvasLayer/HBoxContainer/VBoxContainer/Fire_Delay_Label.hide() 
		$CanvasLayer/HBoxContainer/VBoxContainer/Reload_Delay_Label.hide() 
		$CanvasLayer/HBoxContainer/VBoxContainer/PreReload_Delay_Label.hide()

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
			
			shoot(1, spread, false)
	
	if Input.is_action_just_pressed("m_2") and mag == mag_size:
		if not prereload_timer.paused:
			prereload_timer.start()
		if mag > 0:
			
			shoot(2, spread*1.5, true)
	
	$CanvasLayer/HBoxContainer/Mag_Label.text = str(mag) + '/' + str(mag_size)
	$CanvasLayer/HBoxContainer/VBoxContainer/Fire_Delay_Label.text = str(snapped(fire_timer.time_left,0.1))
	$CanvasLayer/HBoxContainer/VBoxContainer/Reload_Delay_Label.text = str(snapped(reload_timer.time_left,0.1))
	$CanvasLayer/HBoxContainer/VBoxContainer/PreReload_Delay_Label.text = str(snapped(prereload_timer.time_left,0.1))

func shoot(shell_number, angle_of_spread, push):
	mag = mag - shell_number
	reload_timer.stop()
	if prereload_timer.wait_time > 0:
		prereload_timer.start()
	
	for i in range(shell_number * pellets_per_shell):
		var pellet_inst = pellet.instantiate()
		var pellet_scew = angle_of_spread/2 - i*(angle_of_spread/((shell_number*pellets_per_shell)-1))
		pellet_inst.init(get_parent().get_parent(), damage, pellet_speed, pellet_lifetime, $Pivot.global_position, 
		$Pivot.global_rotation + deg_to_rad(pellet_scew), 
		push, push_distance)
		world.add_child(pellet_inst)
	
	fire_timer.start()

func _on_fire_timer_timeout():
	if Input.is_action_pressed("m_1") and mag > 0:
		shoot(1, spread, false)
	else:
		prereload_timer.start()

func _on_pre_reload_timer_timeout():
	mag = mag_size

func _on_reload_timer_timeout():
	mag = mag + 1
	if mag < mag_size:
		reload_timer.start()
		
