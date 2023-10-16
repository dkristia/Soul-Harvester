extends Area2D

@export var picked_up = false
var t = 0

@export var pickup_pos = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	var screen = get_viewport().get_visible_rect().size * 2
	position = Vector2(
		screen.x * randf(),
		screen.y * randf()
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if picked_up:
		t += delta
		
		position = pickup_pos.lerp(get_parent().get_node("Player").position, t)

func _on_timer_timeout():
	queue_free()
