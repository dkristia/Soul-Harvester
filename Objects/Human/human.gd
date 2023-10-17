extends Area2D

var isDead = false
var rng = RandomNumberGenerator.new()
@export var pickup_pos = Vector2(0, 0)
var _random_numberx
var _random_numbery

var _soul = preload("res://Objects/Soul/soul.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var screen = get_viewport().get_visible_rect().size * 2
	position = Vector2(
		screen.x * randf(),
		screen.y * randf()
	)
	_on_timer_2_timeout()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2(_random_numberx, _random_numbery) * delta * 60

func _on_timer_2_timeout():
	var timer = $Timer2
	timer.wait_time=rng.randf_range(0, 5)
	timer.start()

	_random_numberx = rng.randf_range(-4.0, 4.0) 
	_random_numbery = rng.randf_range(-3.0, 3.0) 

func _on_timer_3_timeout():
	var DEAD = rng.randi_range(1, 2)
	if DEAD == 1:
		kill()
		
func kill():
	var soul = _soul.instantiate()
	soul.position = position
	add_sibling(soul)
	queue_free()
