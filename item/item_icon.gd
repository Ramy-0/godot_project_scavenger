extends Control

@export var item_name : String
@export var icon_texture : Texture2D
@export var amount : int

func init(item : ItemClass):
	icon_texture = item.texture
	item_name = item.item_name
	amount = item.amount
	$TextureRect.texture = icon_texture
	$Label.text = 'X' + str(amount)
