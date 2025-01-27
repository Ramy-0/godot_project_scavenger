extends Control

#@export var item_scene : PackedScene = preload("res://item/item_pizza.tscn")
#@export var amount : int
#
#@export var item : ItemClass

#func _ready() -> void:
	##item = item_scene.instantiate()
	#if item != null:
		#$TextureButton.texture_normal = item.texture
	#$AmountLabel.text = "x" + str(amount)

func init(item_p : ItemClass):
	
	if item_p != null:
		$TextureButton.texture_normal = item_p.texture
	$AmountLabel.text = "x" + str(item_p.amount)
	

func _on_texture_button_pressed() -> void:
	print(self, " had been clicked")
