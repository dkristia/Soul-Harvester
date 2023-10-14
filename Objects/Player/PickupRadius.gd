extends Area2D

var mode = 1
@onready var sprite = $Radius
@onready var _radius = preload("res://Objects/Player/radius.tscn")

func _process(delta):
	sprite.modulate.a += 0.1 * delta * mode
	sprite.scale += Vector2(0.1, 0.1) * delta
	if sprite.modulate.a >= 0.2:
		mode = -1
	if sprite.modulate.a <= 0:
		sprite.queue_free()
		var newsprite = _radius.instantiate()
		add_child(newsprite)
		sprite = newsprite
		mode = 1
