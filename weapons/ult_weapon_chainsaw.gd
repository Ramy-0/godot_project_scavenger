extends UltWeaponClass

@export var damage : int = 50

func _physics_process(delta: float) -> void:
	$Pivot.look_at(get_global_mouse_position())
	$Pivot.rotate(PI)
	if $Pivot.rotation > (2 * PI) :
		$Pivot.rotate(- 2 * PI)
	elif $Pivot.rotation < 0.0:
		$Pivot.rotate(2 * PI)
	$Pivot/AnimatedSprite2D.flip_v = ($Pivot.rotation > 0.5 * PI and $Pivot.rotation < 1.5 * PI )
