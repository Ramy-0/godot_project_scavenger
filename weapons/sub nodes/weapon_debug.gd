extends Control

@onready var ammo = $Ammo_DB
@onready var reload = $Reload_DB

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ammo.text = str(get_parent().mag)
	reload.text = str(get_parent().reloadTimer.time_left)
