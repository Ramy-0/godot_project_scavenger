extends Control

@export var objectiveDir : Node2D
@export var player: PlayerClass

@onready var invItems : ItemList = $HBoxContainer/InventoryList
@onready var quoItems : ItemList = $HBoxContainer/QuotaList
@onready var valueLabel : Label = $ValueLabel

@onready var quota : float = 3.0

var priceT : float
var items : Array
var itemAmount : Array

func _ready() -> void:
	if MyFuncs.get_fst_parent_in(self, "Objective") != null:
		objectiveDir = MyFuncs.get_fst_parent_in(self, "Objective")
		print("the objective director is " , objectiveDir)
	else:
		print("no objective director found")
	
	#player = get_tree().get_nodes_in_group("Player")[0]
	player = get_tree().get_first_node_in_group("Player")
	print("Player is ", player)
	
	_calulate()
	hide()

#func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventKey:
		#if event.pressed and event.keycode == KEY_ESCAPE and objectiveDir.uiOpen == true:
			#close()

func open():
	invItems.clear()
	_calulate()
	items = MyFuncs.get_children_in_group(player.get_node("Item_Handler"), "Item")
	for i in range(len(items)):
		invItems.add_item(items[i].item_name + "  x" +str(items[i].amount), items[i].texture, true)
		invItems.set_item_metadata(i, items[i].amount)
	show()

func close():
	quoItems.clear()
	#get_parent().get_parent().world.get_tree().paused = false
	get_parent().get_parent().get_node("../UI/Pause_Menu").unpause_game()
	hide()
	objectiveDir.uiOpen = false
	get_tree().paused = false

func _calulate():
	priceT = 0.0
	for i in range(quoItems.item_count):
		print(quoItems.get_item_metadata(i))
		priceT = priceT + float(quoItems.get_item_metadata(i))
	
	valueLabel.text = "Value = " + str(priceT) + " / " + str(quota)
	if priceT >= quota:
		valueLabel.set("theme_override_colors/font_color", Color.GREEN)
		$HBoxContainer2/SendButton.disabled = false
	else:
		valueLabel.set("theme_override_colors/font_color", Color.RED)
		$HBoxContainer2/SendButton.disabled = true
		

func _on_inventory_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	#print(invItems.get_item_text(index) + "had been clicked by")
	#print("mouse ", mouse_button_index)
	if mouse_button_index == 1 and invItems.get_item_metadata(index) > 0:
		invItems.set_item_metadata(index, invItems.get_item_metadata(index) - 1)
		invItems.set_item_text(index, items[index].item_name + "  x" + str(invItems.get_item_metadata(index)))
		
		quoItems.add_item(items[index].item_name, items[index].texture, true)
		quoItems.set_item_metadata(quoItems.item_count - 1, 1.25)
		
	
	if mouse_button_index == 2 and invItems.get_item_metadata(index) < items[index].amount:
		invItems.set_item_metadata(index, invItems.get_item_metadata(index) + 1)
		invItems.set_item_text(index, items[index].item_name + "  x" + str(invItems.get_item_metadata(index)))
		
		for i in range(quoItems.item_count):
			if quoItems.get_item_text(i) == items[index].item_name:
				quoItems.remove_item(i)
				break
	_calulate()

func _on_quota_list_item_selected(index: int) -> void:
	for i in range(invItems.item_count):
		if quoItems.get_item_text(index) == items[i].item_name:
			invItems.set_item_metadata(i, invItems.get_item_metadata(i) + 1)
			invItems.set_item_text(i, items[i].item_name + "  x" + str(invItems.get_item_metadata(i)))
			quoItems.remove_item(index)
			break
	_calulate()


func _on_back_button_pressed() -> void:
	close()
