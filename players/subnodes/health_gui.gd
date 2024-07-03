extends AspectRatioContainer

class_name HealthGUI

func _process(delta):
	$HBoxContainer/Label2.text = str(get_parent().health)
	$ProgressBar.value = get_parent().health / get_parent().base_health
