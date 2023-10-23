extends Area2D

var isDead = false
@export var pickup_pos = Vector2(0, 0)
var _random_numberx
var _random_numbery

var _soul = preload("res://Objects/Soul/soul.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$Timer3.wait_time = randf_range(10, 20)
	$Timer3.start()
	position = Vector2(
		randf_range(-3700, 3700),
		randf_range(-3700, 3700)
	)
	_on_timer_2_timeout()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2(_random_numberx, _random_numbery) * delta * 60
	if position.x > 3700:
		position.x = 3700
	elif position.x < -3700:
		position.x = -3700
	if position.y > 3700:
		position.y = 3700
	elif position.y < -3700:
		position.y = -3700

func _on_timer_2_timeout():
	var timer = $Timer2
	randomize()
	timer.wait_time=randf_range(0, 5)
	timer.start()

	_random_numberx = randf_range(-4.0, 4.0) 
	_random_numbery = randf_range(-3.0, 3.0) 

func _on_timer_3_timeout():
	randomize()
	var DEAD = randf_range(0, 1)
	if DEAD <= 0.5:
		kill()
	$Timer3.wait_time = randf_range(5, 15)
	$Timer3.start()
	
func kill():
	var soul = _soul.instantiate()
	soul.position = position
	add_sibling(soul)
	queue_free()
