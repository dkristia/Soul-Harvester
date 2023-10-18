extends Node2D


var time = 120
var animationPlayed = false
@onready var _soul = preload("res://Objects/Human/human.tscn")
@onready var global = $"/root/Global"
@onready var _animated_sprite = $GUI/CanvasLayer/EyeContainer/Eyes/EyeSprite
@onready var _allegiance_icon = $GUI/CanvasLayer/LeftBox/AllegianceIcon
@onready var _time_label = $GUI/CanvasLayer/LeftBox/Time/TimeLabel
@onready var player = $Player
@onready var playersprite = player.get_node("MainSprite")
var anubis_path = preload("res://Assets/Icons/Anubisss.png")
var death_path = preload("res://Assets/Icons/Death.png")


func _ready():
	refresh_mode()

func _process(delta):
	_time_label.text = "Time left: " + str(round(time))
	if time < 0:
		time = 0
		global.dead = true
	else:
		time -= delta
		
	if Input.is_action_just_pressed("switchMode"):
		global.AnubisMode = !global.AnubisMode
		refresh_mode()
	
	if Input.is_action_just_pressed("sell"):
		if !global.AnubisMode:
			print("death")
			global.score += global.souls * global.sLevel * 2
			global.bad += global.souls
			time += global.souls * global.sLevel / 2
		else:
			print("good")
			global.good += global.souls * global.sLevel
			global.score += global.souls * global.sLevel
			global.bad -= global.souls
		global.souls = 0
	
	if global.dead and !animationPlayed:
		_animated_sprite.play("eyes_open")
		await _animated_sprite.animation_finished
		animationPlayed = true
	
	if global.good <= 0 or global.bad/global.good >= 2:
		global.dead = true
		
func _on_soul_spawner_timeout():
	var soul = _soul.instantiate() 
	add_child(soul)

func refresh_mode():
	global.speed = 20 if global.AnubisMode else 40
	_allegiance_icon.texture = anubis_path if global.AnubisMode == true else death_path
	playersprite.play("anubis" if global.AnubisMode else "death")
	global.souls = 0
	global.sLevel = 1
