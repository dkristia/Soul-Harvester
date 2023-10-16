extends Area2D

@export var picked_up = false
var t = 0
var isDead = false
var rng = RandomNumberGenerator.new()
@export var pickup_pos = Vector2(0, 0)
var _random_numberx
var _random_numbery

# Called when the node enters the scene tree for the first time.
func _ready():
	var screen = get_viewport().get_visible_rect().size * 2
	position = Vector2(
		screen.x * randf(),
		screen.y * randf()
	)
	rng = RandomNumberGenerator.new()
	
	_on_timer_2_timeout()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !isDead: 
		position += Vector2(_random_numberx, _random_numbery)
	else:
		if picked_up:
			t += delta
			position = pickup_pos.lerp(get_parent().get_node("Player").position, t)

func _on_timer_timeout():
	queue_free()
	
func _on_timer_2_timeout():
	var timer = $Timer2
	timer.wait_time=rng.randf_range(0, 5)
	timer.start()

	_random_numberx = rng.randf_range(-4.0, 4.0) 
	_random_numbery = rng.randf_range(-3.0, 3.0) 

func _on_timer_3_timeout():
	var DEAD = rng.randi_range(1, 2)
	if DEAD == 1:
		isDead = true
