extends Node2D

class_name UltWeaponClass

@export var active : bool = false
@export var weapon_name : String
@export_multiline var weapon_discription : String

@export var world : Node2D

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
