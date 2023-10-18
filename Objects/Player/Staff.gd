extends Node2D

func _process(delta):
	look_at(get_global_mouse_position())
	if rotation_degrees >= 270:
		rotation_degrees -= 360
	elif rotation_degrees <= -270:
		rotation_degrees += 360
	if 90 > rotation_degrees and rotation_degrees > -90:
		scale.y = abs(scale.y)
	else:
		scale.y = -abs(scale.y)
