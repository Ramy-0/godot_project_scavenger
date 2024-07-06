extends CharacterBody2D

func attacked(damage):
	$Label.text = str(int($Label.text) + damage)
	$Timer.start()

func _on_timer_timeout():
	$Label.text = ""


#func _on_enemy_hurt_box_area_entered(area):
	#print("smth hit me")
