extends Control

@export var objectiveDir : Node2D
@export var player: PlayerClass

@onready var invItems : ItemList = $AspectRatioContainer/HBoxContainer/InventoryList
@onready var quoItems : ItemList = $AspectRatioContainer/HBoxContainer/QuotaList

var quota : float
var items : Array
var itemAmount : Array

func _ready() -> void:
	if MyFuncs.get_fst_parent_in(self, "Objective") != null:
		objectiveDir = MyFuncs.get_fst_parent_in(self, "Objective")
		print("the objective director is " , objectiveDir)
	else:
		print("no objective director found")
	
	player = get_tree().get_nodes_in_group("Player")[0]
	print("Player is ", player)
	
	
	hide()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			close()
		
		if event.pressed and event.keycode == KEY_SPACE:
			print("jump")

func open():
	invItems.clear()
	items = MyFuncs.get_children_in_group(player.get_node("Item_Handler"), "Item")
	for i in range(len(items)):
		invItems.add_item(items[i].item_name + "  x" +str(items[i].amount), items[i].texture, true)
		invItems.set_item_metadata(i, items[i].amount)
	
	
	show()

func close():
	
	quoItems.clear()
	hide()

func _on_inventory_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	#print(invItems.get_item_text(index) + "had been clicked by")
	#print("mouse ", mouse_button_index)
	if mouse_button_index == 1 and invItems.get_item_metadata(index) > 0:
		invItems.set_item_metadata(index, invItems.get_item_metadata(index) - 1)
		invItems.set_item_text(index, items[index].item_name + "  x" + str(invItems.get_item_metadata(index)))
		
		quoItems.add_item(items[index].item_name, items[index].texture, true)
	
	if mouse_button_index == 2 and invItems.get_item_metadata(index) < items[index].amount:
		invItems.set_item_metadata(index, invItems.get_item_metadata(index) + 1)
		invItems.set_item_text(index, items[index].item_name + "  x" + str(invItems.get_item_metadata(index)))
		
		for i in range(quoItems.item_count):
			if quoItems.get_item_text(i) == items[index].item_name:
				quoItems.remove_item(i)
				break


func _on_quota_list_item_selected(index: int) -> void:
	for i in range(invItems.item_count):
		if quoItems.get_item_text(index) == items[i].item_name:
			invItems.set_item_metadata(i, invItems.get_item_metadata(i) + 1)
			invItems.set_item_text(i, items[i].item_name + "  x" + str(invItems.get_item_metadata(i)))
			quoItems.remove_item(index)
			break
