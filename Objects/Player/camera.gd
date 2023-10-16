extends Camera2D

var starting = true
var zoomDerivative = 0.98

func _ready():
	zoom = Vector2(0.01, 0.01)

func _process(delta):
	if starting:
		_start_zoom(delta)
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

func _start_zoom(delta):
	zoomDerivative = zoomDerivative**1.1
	zoom += delta * Vector2(zoomDerivative, zoomDerivative)
	if zoom >= Vector2(1, 1):
		starting = false
