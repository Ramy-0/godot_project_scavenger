extends Control

@export var amount: int = 1
@export var value: float = 1.25

func init(item : ItemClass):
	$HBoxContainer/NameLabel.text = item.name
	$HBoxContainer/TextureRect.texture = item.texture
	
	$HBoxContainer/SpinBox.value = amount
	$HBoxContainer/CostLabel.text = str(amount) + " x " + str(value) + " = " + str(amount*value)
