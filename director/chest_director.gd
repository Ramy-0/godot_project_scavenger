extends Node2D

@export var itemList: Array[PackedScene]
@export var chestsNum: int

@onready var MChest = preload("res://item/chests/chest_m.tscn")
@onready var DChest = preload("res://item/chests/chest_d.tscn")
@onready var world: Node2D
@onready var chestList : Array

func _ready() -> void:
	#world = MyFuncs.get_fst_parent_in(self, "World")
	world = get_parent()
	print(world)
	print("Item Pool :")
	print(itemList)
	
	spawn_init_chests()

func spawn_init_chests():
	for i in chestsNum:
		_spawn_chest_r()

func _spawn_chest_r():
	#print(randi_range(0,2))
	if randi_range(0,1) == 1:
		_spawn_chest_d(0)
	else :
		_spawn_chest_m(0.5)

func _spawn_chest_d(_price: int,):
	var chest = DChest.instantiate()
	chest.init(_price, itemList[randi_range(0, itemList.size()-1)])
	chest.global_position = Vector2(randi_range(-1000, 1000), randi_range(-1000, 1000))
	#world.add_child(chest)
	world.call_deferred("add_child", chest)
	print("adding digital chest")
	print(chest.get_parent())
	
	chestList.append(chest)
	
	queue_redraw()

func _spawn_chest_m(_time:float):
	var chest = MChest.instantiate()
	chest.init(_time, itemList[randi_range(0, itemList.size()-1)])
	chest.global_position = Vector2(randi_range(-1000, 1000), randi_range(-1000, 1000))
	#world.add_child(chest)
	world.call_deferred("add_child", chest)
	print("adding digital chest")
	print(chest.get_parent())
	
	chestList.append(chest)
	
	queue_redraw()

func _draw() -> void:
	for i in chestList:
		draw_circle(i.global_position, 20, Color.GREEN)
