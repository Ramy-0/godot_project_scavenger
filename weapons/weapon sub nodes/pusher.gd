extends Node2D

@export var pushee : CharacterBody2D
@export_enum(
	"from current position", 
	"from initial position",
	"from custom position"
)
var pushFrom : int = 0
@export var fromPosition : Vector2
@export_enum(
	"to position", 
	"to direction"
)
var pushTo : int = 0
@export var toPosition : Vector2
@export var direction : Vector2
@export var distance : float
@export var timeTaken : float
@export var deleteAfter : bool = true

func _ready() -> void:
	direction = direction.normalized()
	if pushee != null and pushFrom == 0:
		fromPosition = pushee.global_position
	if pushTo == 1:
		toPosition = fromPosition + direction * distance
	if pushee != null:
		print("Should push")
		push(pushee)

func push(pushee):
	print("pushing ", pushee)
	var pushTween = get_tree().create_tween()
	pushTween.tween_property(pushee, "position", toPosition, timeTaken)
	await pushTween.finished
	print("tween finished")
	if deleteAfter:
		queue_free()
