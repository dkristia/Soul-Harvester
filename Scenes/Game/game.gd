extends Node2D

var timer
var animationPlayed = false
@onready var _soul = preload("res://Objects/Human/human.tscn")
@onready var global = $"/root/Global"
@onready var _animated_sprite = $GUI/CanvasLayer/EyeContainer/Eyes/EyeSprite
@onready var _allegiance_icon = $GUI/CanvasLayer/LeftBox/AllegianceIcon
var anubis_path = preload("res://Assets/Icons/Anubisss.png")
var death_path = preload("res://Assets/Icons/Death.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	if Input.is_action_just_pressed("switchMode"):
		global.AnubisMode = !global.AnubisMode
		global.speed = 20 if global.AnubisMode else 40
		_allegiance_icon.texture = anubis_path if global.AnubisMode == true else death_path
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
		_animated_sprite.play("eyes_open")
		await _animated_sprite.animation_finished
		animationPlayed = true
		
	if  global.bad/global.good > 2:
		global.dead = true
		
func _on_soul_spawner_timeout():
	var soul = _soul.instantiate() 
	add_child(soul)

