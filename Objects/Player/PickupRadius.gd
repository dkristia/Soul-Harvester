extends Area2D

var mode = 1
@onready var sprite = $Radius
@onready var _radius = preload("res://Objects/Player/radius.tscn")

func _process(delta):
	sprite.modulate.a += 0.1 * delta * mode * 4
	sprite.scale += Vector2(0.2, 0.2) * delta * 4
	
	if sprite.scale > Vector2(0.65, 0.65):
		sprite.scale = Vector2(0.65, 0.65)
	
	if sprite.modulate.a >= 0.2:
		mode = -1
	elif sprite.modulate.a <= 0:
		sprite.queue_free()
		var newsprite = _radius.instantiate()
		add_child(newsprite)
		sprite = newsprite
		mode = 1
	
	if Input.is_action_just_pressed("ui_accept"):
		scale += Vector2(0.1, 0.1)
