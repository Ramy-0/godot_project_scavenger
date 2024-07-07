extends Node2D

@export var killer_blow : bool = false

func init(pos):
	global_position = pos

func _on_animated_sprite_2d_animation_finished():
	queue_free()
