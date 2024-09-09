extends StaticBody2D

@export var coinsToOpen: int
@export var item:PackedScene

var state: int = 0
var player_near: bool = false
var player_has_coins: bool = false
var itemHolder: PackedScene = preload("res://item/item_holder.tscn")

func _ready() -> void:
	pass

func init(_price: int, _item: PackedScene):
	if _price == null:
		_price = 0
	coinsToOpen = _price
	if _item != null:
		item = _item

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("kb_e") and player_near and player_has_coins and state == 0:
		state = 1
		open()
	#if state == 1:
		#$Label.text = str($OpeningTimer.time_left)


func _on_interact_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and state == 0:
		$HintLabel.show()
		player_near = true
		if body.coins >= coinsToOpen:
			player_has_coins = true

func _on_interact_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player") and state == 0:
		$HintLabel.hide()
		player_near = false
		player_has_coins = false

func open():
	var drop_pos = global_position+Vector2.ONE.rotated(randf_range(0, 2*PI))*250
	$AnimatedSprite2D.frame = 1
	var itemH = itemHolder.instantiate()
	itemH.item_scene = item
	itemH.global_position = global_position
	get_parent().add_child(itemH)
	print(itemH)
	var animTween1 = create_tween()
	animTween1.tween_property(itemH, "global_position:x", drop_pos.x, 0.8)
	var animTween2 = create_tween()
	animTween2.tween_property(itemH, "position:y", drop_pos.y-70, 0.4).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	animTween2.tween_property(itemH, "position:y", drop_pos.y, 0.4).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
