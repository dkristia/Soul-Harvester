extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var screen = get_viewport().get_visible_rect().size
	position = Vector2(
		screen.x * randf(),
		screen.y * randf()
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
