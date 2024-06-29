extends CharacterBody2D

class_name PlayerV1

#Player constants:
const speed: float = 300.0

#children nodes:
@onready var weaponsBelt = $WeaponsBelt

var weapons_list: Array

func _ready():
	weapons_list = weaponsBelt.get_children()
	print(weapons_list)
	weapons_list[0].set_active(true)

func _physics_process(delta):
	
	#movement:
	var direction = Input.get_vector("kb_left", "kb_right", "kb_up", "kb_down")
	velocity = direction * speed

	move_and_slide()

func hit(damage):
	print("owies")
