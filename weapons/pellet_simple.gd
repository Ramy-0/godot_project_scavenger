extends RigidBody2D

class_name PelletClass

var parent: CharacterBody2D
var damage: int
var speed: float
var can_push : bool = false
var push_distance : float

var dontdeljustyet : bool = false

@export var hit_marker : PackedScene = preload("res://weapons/weapon sub nodes/hit_marker.tscn")

var dir = Vector2.RIGHT
var init_pos : Vector2

func _ready():
	contact_monitor = true
	init_pos = global_position
	
	$Player_HitBox_Moving.hitbox_attack.connect(hitbox_hit)

func _physics_process(delta):
	translate(dir.normalized() * speed * delta)
	queue_redraw()
	#print(init_pos)

func _draw():
	pass
	#print(global_position, position, init_pos)
	#draw_line(Vector2.ZERO, Vector2(-abs(global_position.x-init_pos.x), 0), Color.RED, 2.0)
	#draw_circle(Vector2.ZERO, 16, Color.AQUA)

func init(p_parent, p_damage, p_speed, p_lifetime, p_position, p_rotation, p_push, p_push_dis):
	parent = p_parent
	damage = p_damage
	speed = p_speed
	position = p_position
	rotation = p_rotation
	can_push = p_push
	push_distance = p_push_dis
	$Timer.wait_time = p_lifetime
	
	dir = dir.rotated(rotation)
	
	#init_pos = global_position


func hit_mark(target):
	var hm = hit_marker.instantiate()
	hm.init(global_position)
	MyFuncs.get_fst_parent_in(self, "World").add_child(hm)


func _on_timer_timeout():
	if not dontdeljustyet:
		queue_free()


func _on_area_2d_body_entered(_body):
	if not dontdeljustyet:
		queue_free()

func _on_player_hit_box_moving_area_entered(area):
	hit_mark(area)

func hitbox_hit(hurtbox):
	parent.itemHandler.on_attacking($Player_HitBox_Moving, hurtbox)
	if can_push:
		print("push")
		#hurtbox.parent.global_position += global_position.direction_to(hurtbox.parent.global_position).normalized()* push_distance
		#hurtbox.parent.global_position += dir * push_distance
		var push = get_tree().create_tween()
		push.tween_property(
			hurtbox.parent, "position",
		 	hurtbox.parent.position + dir * push_distance, 0.7
		 ).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)

func _on_body_entered(body: Node) -> void:
	if not dontdeljustyet:
		queue_free()
