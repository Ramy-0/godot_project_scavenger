extends StaticBody2D

@export var timeToOpen : float
@export var item : PackedScene

var state: int = 0
var player_near : bool = false
var itemHolder: PackedScene = preload("res://item/item_holder.tscn")

var animTweenX : Tween
var animTweenY : Tween

func _ready() -> void:
	$OpeningTimer.wait_time = timeToOpen
	animTweenX = create_tween().set_loops()
	animTweenX.tween_property($AnimSpriteAnchor, "scale:x",0.8, 1.2)
	animTweenX.tween_property($AnimSpriteAnchor, "scale:x",1.2, 0.8)
	animTweenX.pause()
	animTweenY = create_tween().set_loops()
	animTweenY.tween_property($AnimSpriteAnchor, "scale:y",1.2, 0.8)
	animTweenY.tween_property($AnimSpriteAnchor, "scale:y",0.8, 1.2)
	animTweenY.pause()

func init(_time: float, _item: PackedScene):
	if _time == null:
		_time = 0.5
	timeToOpen = _time
	if _item != null:
		item = _item

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("kb_e") and player_near and state == 0:
			$OpeningTimer.start()
			#print("opening")
			state = 1
			animTweenX.play()
			animTweenY.play()
			
	if state == 1:
		$Label.text = str($OpeningTimer.time_left)

func _on_interact_area_body_entered(body: Node2D) -> void:
	if state == 0:
		$HintLabel.show()
		player_near = true

func _on_interact_area_body_exited(body: Node2D) -> void:
	if state == 0:
		$HintLabel.hide()
		player_near = false

func _on_opening_area_body_entered(body: Node2D) -> void:
	if state == 1:
		player_near = true
		$OpeningTimer.paused = false
		animTweenX.play()
		animTweenY.play()

func _on_opening_area_body_exited(body: Node2D) -> void:
	if state == 1:
		player_near = false
		$OpeningTimer.paused = true
		animTweenX.pause()
		animTweenY.pause()


func _on_opening_timer_timeout() -> void:
	open()
	animTweenX.kill()
	animTweenY.kill()
	$AnimSpriteAnchor.scale = Vector2(1,1)

func open():
	var drop_pos = global_position+Vector2.ONE.rotated(randf_range(0, 2*PI))*250
	$AnimSpriteAnchor/AnimatedSprite2D.frame = 1
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
