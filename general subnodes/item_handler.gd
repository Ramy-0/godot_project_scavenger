extends Node2D

class_name ItemHandler

var items : Array
var parent: Node2D

func _ready():
	parent = get_parent()
	parent.hurtBox.hurtbox_attacked.connect(_on_attacked)

func _on_update_timer_timeout():
	items = MyFuncs.get_children_in_group(self, "Item")
	for i in items:
		if i.has_method("use"):
			i.use(i.amount)

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
