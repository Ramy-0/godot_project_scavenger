extends RigidBody2D

class_name BulletClass

var parent: CharacterBody2D
var damage: int
var speed: float

var dir = Vector2.RIGHT

func _ready():
	contact_monitor = true

func init(p_parent, p_damage, p_speed, p_lifetime, p_position, p_rotation):
	parent = p_parent
	damage = p_damage
	speed = p_speed
	position = p_position
	rotation = p_rotation
	$Timer.wait_time = p_lifetime
	
	dir = dir.rotated(rotation)

func _physics_process(delta):
	translate(dir.normalized() * speed * delta)


func _on_timer_timeout():
	queue_free()

func _on_area_2d_body_entered(_body):
	queue_free()


#func _on_player_hit_box_moving_area_entered(area):
	#print("hit sth")
