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

@export var bleed_mult : int = 1
@export var burn_mult : int = 1

#@onready var bleedIcon = preload("res://general subnodes/status effect icon/se_bleed_icon.tscn")

func _ready():
	parent = get_parent()

func _process(delta):
	if status["bleed"] > 0:
		bleed(delta)
		$StatusContainer/SE_Bleed_Icon.show()
		$StatusContainer/SE_Bleed_Icon/TextureRect/Mult_Label.text = 'X' + str(bleed_mult)
		$StatusContainer/SE_Bleed_Icon/TextureRect/Timer_Label.text = str(snapped(status["bleed"], 0.1))
	else:
		$StatusContainer/SE_Bleed_Icon.hide()
	if status["burn"] > 0:
		burn(delta)
		$StatusContainer/SE_Burn_Icon.show()
		$StatusContainer/SE_Burn_Icon/TextureRect/Mult_Label.text = 'X' + str(burn_mult)
		$StatusContainer/SE_Burn_Icon/TextureRect/Timer_Label.text = str(snapped(status["burn"], 0.1))
	else:
		$StatusContainer/SE_Burn_Icon.hide()

func update_timer(delta):
	status["bleed"] -= delta
	status["burn"] -= delta
	status["stun"] -= delta

func bleed(delta):
	status["bleed"] -= delta
	if status["bleed"] <= 0 :
		burn_mult = 1
	bleed_subtimer += delta
	if bleed_subtimer > 0.5 :
		parent.attacked(0.1 * parent.health * bleed_mult)
		bleed_subtimer = 0.0

func burn(delta):
	status["burn"] -= delta
	if status["burn"] <= 0 :
		burn_mult = 1
	burn_subtimer += delta
	if burn_subtimer > 0.5 :
		parent.attacked(0.05 * parent.max_health * burn_mult)
		burn_subtimer = 0.0
