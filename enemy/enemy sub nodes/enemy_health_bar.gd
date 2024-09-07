extends Control

@export var parent: CharacterBody2D

func _ready() -> void:
	if parent == null:
		parent = get_parent()

func _process(delta: float) -> void:
	$TextureProgressBar.max_value = parent.max_health
	$TextureProgressBar.value = parent.health
	$Label.text = str(parent.health)
