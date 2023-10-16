extends Area2D

var mode = 1
@onready var sprite = $Radius
@onready var _radius = preload("res://Objects/Player/radius.tscn")
@onready var global = $"/root/Global"

@export var activated = false

func _process(delta):
	if activated:
		sprite.modulate.a += 0.4 * delta * mode
		sprite.scale += Vector2(0.8, 0.8) * delta
		
		if sprite.scale > Vector2(0.325, 0.325):
			sprite.scale = Vector2(0.325, 0.325)
		
		if sprite.modulate.a >= 0.2:
			mode = -1
		elif sprite.modulate.a <= 0:
			mode = 1
			sprite.modulate.a = 0
			sprite.scale = Vector2(0, 0)
			global.ability_radius_multiplier = 1
			activated = false
