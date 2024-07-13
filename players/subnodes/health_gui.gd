extends AspectRatioContainer

class_name HealthGUI

var parent : CharacterBody2D

func _ready():
	parent = MyFuncs.get_fst_parent_in(self, "Player")

func _process(delta):
	$VBoxContainer/HBoxContainer/Label2.text = str(snapped(parent.health,0.1))
	$VBoxContainer/ProgressBar.value = parent.health / parent.max_health
