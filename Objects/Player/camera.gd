extends Camera2D


func _process(delta):
	var za = zoom.x * 0.2
	var zoomamount = Vector2(za, za)
	if Input.is_action_just_pressed("zoomout"):
		zoom -= zoomamount
	if Input.is_action_just_pressed("zoomin"):
		zoom += zoomamount
		
	if zoom.x > 3:
		zoom = Vector2(3, 3)
	elif zoom.x < 0.2:
		zoom = Vector2(0.2, 0.2)
