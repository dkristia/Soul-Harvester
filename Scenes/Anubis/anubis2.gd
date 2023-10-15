extends Node2D



func _process(delta):
	if Input.is_action_just_pressed("up"):
		$Good.mass += 0.1
		$Good.position.y += 0.01
		
	if Input.is_action_just_pressed("down"):
		$Bad.mass += 0.1
		$Bad.position.y += 0.01
		
