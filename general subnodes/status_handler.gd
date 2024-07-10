extends Node2D

class_name StatusHandler

@export var parent : CharacterBody2D
@export var status : Dictionary = {
		"bleed" : 0.0,
		"burn" : 0.0,
		"stun" : 0.0
	}

var bleed_subtimer : float = 0.0
var burn_subtimer : float = 0.0
var stun_subtimer : float = 0.0

@export var bleed_mult : int = 0

func _ready():
	parent = get_parent()

func _process(delta):
	if status["bleed"] > 0:
		bleed(delta)

func update_timer(delta):
	status["bleed"] -= delta
	status["burn"] -= delta
	status["stun"] -= delta

func bleed(delta):
	status["bleed"] -= delta
	bleed_subtimer += delta
	if bleed_subtimer > 0.5 :
		parent.attacked(0.1 * parent.health * bleed_mult)
		bleed_subtimer = 0.0
	
