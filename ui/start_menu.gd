extends Control


func _on_button_pressed():
	pass
	#get_tree().change_scene_to_packed(preload("res://worlds/world_1.tscn"))

func _on_button_2_pressed():
	get_tree().change_scene_to_packed(preload("res://worlds/world_2.tscn"))

func _on_button_3_pressed():
	pass
	#get_tree().change_scene_to_packed(preload("res://worlds/world_test.tscn"))

func _on_button_4_pressed():
	get_tree().change_scene_to_packed(preload("res://worlds/world_director_test.tscn"))

func _on_button_5_pressed() -> void:
	get_tree().change_scene_to_packed(preload("res://worlds/world_punshing_bags.tscn"))

func _on_button_6_pressed() -> void:
	get_tree().change_scene_to_packed(preload("res://worlds/world_chest_director_test.tscn"))
