extends Node2D

class_name ItemHandler

var items : Array
var items_names : Array
var parent: Node2D

@export var can_pickup : bool = true

@onready var icon_sc = preload("res://item/item_icon.tscn")

func _ready():
	parent = get_parent()
	parent.hurtBox.hurtbox_attacked.connect(_on_attacked)
	_update_items_icons()

func _on_update_timer_timeout():
	items = MyFuncs.get_children_in_group(self, "Item")
	items_names = []
	for i in items:
		if i.has_method("use"):
			i.use(i.amount)
		items_names.append(i.item_name)

func _update_items_icons():
	for i in $CanvasLayer/VBoxContainer/HBoxContainer.get_children():
		i.queue_free()
	items = MyFuncs.get_children_in_group(self, "Item")
	#var icons = $CanvasLayer/VBoxContainer/HBoxContainer.get_children()
	for i in items:
		if i.amount > 0:
			var ic = icon_sc.instantiate()
			ic.init(i)
			$CanvasLayer/VBoxContainer/HBoxContainer.add_child(ic)
		else:
			i.queue_free()

func on_critical(hitbox, hurtbox):
	hitbox.damage *= 2
	print("crit")
	for i in items:
		if i.has_method("use_when_critical"):
			i.use_when_critical(hitbox, hurtbox)

func _on_attacked():
	for i in items:
		if i.has_method("use_when_attacked"):
			i.use_when_attacked()

func _on_attacking():
	pass

func on_attacking(hitbox, hurtbox):
	for i in items:
		if i.has_method("use_when_attacking"):
			i.use_when_attacking(hitbox, hurtbox)


func _on_collect_area_area_entered(area):
	print(area.get_parent().item_name)
	if area.get_parent().item_name in items_names:
		for i in items:
			if i.item_name == area.get_parent().item_name:
				i.amount += 1
	else:
		var item_inst = area.get_parent().item_scene.instantiate()
		item_inst.amount = 1
		add_child(item_inst)
	
	_update_items_icons()
	area.get_parent().queue_free()
