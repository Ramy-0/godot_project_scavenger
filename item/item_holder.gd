extends Node2D

@export var item_scene : PackedScene = preload("res://item/item_pizza.tscn")
@export var can_be_picked:bool = true

var item : ItemClass
var item_name : String

func _ready():
	#await  get_tree().create_timer(0.1).timeout
	item = item_scene.instantiate()
	item_name = item.item_name
	$Sprite2D.texture = item.texture
	if item.is_class("ItemClass"):
		print("yes")
		$Sprite2D.texture = item.texture
	
	$Name_Label.text = item.item_name
	$Name_Label.hide()
	$Description_Label.text = item.flavor_text
	$Description_Label.hide()
	can_be_picked = false
	await get_tree().create_timer(0.3).timeout
	can_be_picked = true
	$Iteract_Area.monitorable = true


func _on_name_area_mouse_entered():
	$Name_Label.show()


func _on_name_area_mouse_exited():
	await  get_tree().create_timer(0.1).timeout
	$Name_Label.hide()


func _on_iteract_area_mouse_entered():
	$Description_Label.show()


func _on_iteract_area_mouse_exited():
	$Description_Label.hide()
