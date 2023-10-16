extends Node2D

var timer
var animationPlayed = false
@onready var _soul = preload("res://Objects/Soul/soul.tscn")
@onready var global = $"/root/Global"
@onready var _animated_sprite = $GUI/CanvasLayer/ColorRect/AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	if Input.is_action_just_pressed("switchMode"):
		global.AnubisMode = !global.AnubisMode
		global.souls = 0
		global.sLevel = 1

	if Input.is_action_just_pressed("sell"):
		if !global.AnubisMode:
			print("death")
			global.score += global.souls * global.sLevel * 2
			global.bad += global.souls * global.sLevel
		else:
			print("good")
			global.good += global.souls * global.sLevel 
			global.score += global.souls * global.sLevel
		global.souls = 0
		
	if global.dead and !animationPlayed:
		_animated_sprite.play("EyesOpen")
		await _animated_sprite.animation_finished
		animationPlayed = true
		
	if  global.bad/global.good > 2:
		global.dead = true
		
func _on_soul_spawner_timeout():
	var soul = _soul.instantiate() 
	add_child(soul)

