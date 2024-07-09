extends RigidBody2D

class_name BulletClass

var parent: CharacterBody2D
var damage: int
var speed: float

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

func init(p_parent, p_damage, p_speed, p_lifetime, p_position, p_rotation):
	parent = p_parent
	damage = p_damage
	speed = p_speed
	position = p_position
	rotation = p_rotation
	$Timer.wait_time = p_lifetime
	
	dir = dir.rotated(rotation)
	
	#init_pos = global_position


func hit_mark(target):
	var hm = hit_marker.instantiate()
	hm.init(global_position)
	MyFuncs.get_fst_parent_in(self, "World").add_child(hm)


func _on_timer_timeout():
	queue_free()


func _on_area_2d_body_entered(_body):
	queue_free()

func _on_player_hit_box_moving_area_entered(area):
	hit_mark(area)

func hitbox_hit():
	parent.itemHandler.on_attacking($Player_HitBox_Moving)
