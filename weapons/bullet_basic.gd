extends Area2D

var dir = Vector2.RIGHT

@export var dmg: float = 25.0
@export var speed: float = 1500.0

func _ready():
	print("bang")

func init(owner_p, dmg_p, speed_p, pos_p, rot_p):
	self.dmg = dmg
	self.speed = speed
	self.position = pos_p
	self.rotation = rot_p
	self.dir = dir.rotated(rot_p)

func _physics_process(delta):
	translate(dir.normalized() * speed * delta)


func _on_expire_timer_timeout():
	queue_free()
