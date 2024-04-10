extends Control

@onready var ammo = $Ammo_DB
@onready var reload = $Reload_DB

@onready var parent = get_parent()


func _process(delta):
	rotation = - parent.rotation
	ammo.text = str(parent.mag)
	reload.text = str(parent.reloadTimer.time_left)
