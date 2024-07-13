extends Node2D

class_name WeaponClass

@export var active : bool
@export var weapon_name: String
@export var weapon_discription : String

@export var world: Node2D

func _ready():
	world = MyFuncs.get_fst_parent_in(self, "World")

func set_as_inactive():
	process_mode = PROCESS_MODE_DISABLED
	if $CanvasLayer != null:
		$CanvasLayer.hide()
	hide()

func set_as_active():
	process_mode = PROCESS_MODE_INHERIT
	if $CanvasLayer != null:
		$CanvasLayer.show()
	show()
