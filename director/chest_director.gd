extends Node2D

@export var itemList: Array[PackedScene]
@export var chestsNum: int
@export var base_price: int
@export var base_time: float

@onready var MChest = preload("res://item/chests/chest_m.tscn")
@onready var DChest = preload("res://item/chests/chest_d.tscn")
@onready var world: Node2D
@onready var chestList : Array

var chestPosList : Array

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
		_spawn_chest_d(base_price)
	else :
		_spawn_chest_m(base_time)

func _spawn_chest_d(_price: int,):
	var chestPos : Vector2
	while true:
		chestPos = Vector2(randi_range(-1000, 1000), randi_range(-1000, 1000))
		if check_pos(chestPos):
			break
	var chest = DChest.instantiate()
	chest.init(_price, itemList[randi_range(0, itemList.size()-1)])
	chest.global_position = chestPos
	#world.add_child(chest)
	world.call_deferred("add_child", chest)
	print("adding digital chest")
	print(chest.get_parent())
	
	chestList.append(chest)
	
	queue_redraw()

func _spawn_chest_m(_time:float):
	var chestPos : Vector2
	for i in range(20):
		chestPos = Vector2(randi_range(-1000, 1000), randi_range(-1000, 1000))
		if check_pos(chestPos):
			break
	var chest = MChest.instantiate()
	chest.init(_time, itemList[randi_range(0, itemList.size()-1)])
	chest.global_position = chestPos
	#world.add_child(chest)
	world.call_deferred("add_child", chest)
	print("adding manual chest")
	print(chest.get_parent())
	
	chestList.append(chest)
	
	queue_redraw()

func _draw() -> void:
	pass
	#for i in chestList:
		#draw_circle(i.global_position, 20, Color.GREEN)

func check_pos(pos:Vector2):
	var available: bool = true
	available = true
	#$CheckArea.position = pos
	#print($CheckArea.get_overlapping_areas())
	#print($CheckArea.get_overlapping_bodies())
	#if len($CheckArea.get_overlapping_areas()) > 0:
		#available = false
	#
	#if len($CheckArea.get_overlapping_bodies()) > 0:
		#available = false
	
	for i in chestPosList:
		if pos.distance_squared_to(i) < 1200.0:
			print(pos.distance_squared_to(i))
			available = false
			break
	
	if(available):
		print("position available")
		chestPosList.append(pos)
	else:
		print("position not available")
	
	return available
