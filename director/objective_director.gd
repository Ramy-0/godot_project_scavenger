extends Node2D

#@onready var icon_sc = preload("res://item/item_icon.tscn")
@onready var item_button : PackedScene = preload("res://item/item_button.tscn")

@onready var inventory_items_container = $UI/ItemMenu/HBoxContainer/InventoryContainer/GridContainer

@export var objectiveType : int = 1
#0: nothing 1: items

var playerNear : bool = false
var uiOpen : bool = false
var world : Node2D
var player : PlayerClass

func _ready() -> void:
	#print(get_node("../UI/Pause_Menu"))
	world = MyFuncs.get_fst_parent_in(self, "World")
	player = MyFuncs.get_children_in_group(world, "Player")[0]
	print(player)
	match objectiveType:
		0:
			pass
		1:
			$UI.show()
			$UI/ObjectiveHintLabel.text = "Collect Items :"

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("kb_e") and uiOpen == false and playerNear ==  true:
		open_ui()
	if Input.is_action_just_pressed("ui_cancel") and uiOpen == true:
		close_ui()
		get_node("../UI/Pause_Menu").unpause_game()

func open_ui():
	$UI/ItemMenu.show()
	uiOpen = true
	world.get_tree().paused = true
	print("player is ", player)
	for i in inventory_items_container.get_children():
		i.queue_free()
	
	print(player.get_node("Item_Handler"))
	for i in MyFuncs.get_children_in_group(player.get_node("Item_Handler"), "Item"):
		#print(i)
		var ib = item_button.instantiate()
		ib.init(i)
		inventory_items_container.add_child(ib)

func close_ui():
	$UI/ItemMenu.hide()
	uiOpen = false
	world.get_tree().paused = false

func _on_interaction_area_body_entered(body: Node2D) -> void:
	$HintLabel.show()
	playerNear = true

func _on_interaction_area_body_exited(body: Node2D) -> void:
	$HintLabel.hide()
	playerNear = false
