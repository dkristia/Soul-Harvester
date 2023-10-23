extends CanvasLayer

var mode = 1
@onready var color = $ColorRect


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	color.color.a += 4 * delta * mode
	if 0.8 <= color.color.a:
		mode = -1
	if color.color.a <= 0:
		queue_free()
