extends Node2D


# Called when the node enters the scene tree for the first time.
var timer
@onready var animationPlayed = false
@onready var _soul = preload("res://Objects/Soul/soul.tscn")
@onready var global = $"/root/Global"
@onready var _animated_sprite = $GUI/CanvasLayer/ColorRect/AnimatedSprite2D
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Anubis"):
		global.AnubisMode = !global.AnubisMode
		global.souls = 0
		global.sLevel = 1

	if Input.is_action_pressed("sell"):
		if !global.AnubisMode:
			global.score += global.souls * global.sLevel * 2
			global.good -= global.souls * global.sLevel
		else:
			global.good += global.souls * global.sLevel 
			global.score += global.souls * global.sLevel
		global.souls = 0
		
	if global.dead and !animationPlayed:
		_animated_sprite.play("EyesOpen")
		await _animated_sprite.animation_finished
		animationPlayed = true
		
func _on_soul_spawner_timeout():
	var soul = _soul.instantiate() 
	add_child(soul)

