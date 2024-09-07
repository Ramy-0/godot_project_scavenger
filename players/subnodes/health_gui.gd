extends Control

class_name HealthGUI

var parent : CharacterBody2D

func _ready():
	parent = MyFuncs.get_fst_parent_in(self, "Player")

func _process(delta):
	$HBoxContainer/Label2.text = str(snapped(parent.health,0.1))
	$TextureProgressBar.value = parent.health / parent.max_health
	if $TextureProgressBar.value >= 0.2:
		$TextureProgressBar.tint_progress = Color.GREEN
	else:
		$TextureProgressBar.tint_progress = Color.RED
