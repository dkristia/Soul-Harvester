extends Camera2D


func _process(delta):
	var za = zoom.x * 0.1
	var zoomamount = Vector2(za, za)
	if Input.is_action_just_pressed("zoomout"):
		zoom -= zoomamount
	if Input.is_action_just_pressed("zoomin"):
		zoom += zoomamount
