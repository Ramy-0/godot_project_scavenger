extends Node2D

class_name WeaponClass

@export var weapon_name: String
@export var weapon_discription : String

@export var world: Node2D

func _ready():
	world = MyFuncs.get_fst_parent_in(self, "World")
