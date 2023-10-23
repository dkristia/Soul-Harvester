extends Node2D


@export var time = 120
var animationPlayed = false
@onready var _soul = preload("res://Objects/Human/human.tscn")
@onready var global = $"/root/Global"
@onready var _animated_sprite = $GUI/Eyes/VBoxContainer/TextureRect
@onready var _allegiance_icon = $GUI/CanvasLayer/LeftBox/AllegianceIcon
@onready var _time_label = $GUI/CanvasLayer/EyeContainer/MarginContainer/TimeLabel
@onready var player = $Player
@onready var playersprite = player.get_node("MainSprite")
@onready var staffsprite = $Player/Staff/Sprite2D
var scythe = preload("res://Assets/Player/Death/Scyhe/scythe.png")
var staff = preload("res://Assets/Player/Anubis/Staff/staff.png")
var anubis_path = preload("res://Assets/Icons/Anubisss.png")
var death_path = preload("res://Assets/Icons/Death.png")


func _ready():
	global.score = 0
	for i in range(100):
		_on_soul_spawner_timeout()
	refresh_mode()

func _process(delta):
	_time_label.text = str(round(time))
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
			global.score += global.souls * global.sLevel * 2
			global.bad += global.souls
			time += global.souls * global.sLevel / 2
		else:
			global.good += global.souls * global.sLevel
			global.score += global.souls * global.sLevel
			global.bad -= global.souls
		global.souls = 0
	
	if global.dead and !animationPlayed:
		$AnubisTheme.stop()
		$DeathTheme.stop()
		get_tree().paused = true
		_animated_sprite.visible = true
		_animated_sprite.texture.pause = false
		$GUI/CanvasLayer.visible = false
		$GUI/CanvasLayer/ColorRect.visible = true
		await get_tree().create_timer(3).timeout
		_animated_sprite.visible = false
		$GUI/CanvasLayer/ColorRect.visible = false
		$GUI/Dead/AudioStreamPlayer.play()
		$GUI/Dead.visible = true
		animationPlayed = true
	
	if global.good <= 0 or global.bad/global.good >= 2:
		print(global.good)
		print(global.bad)
		print(global.bad/global.good)
		global.dead = true
		
func _on_soul_spawner_timeout():
	var soul = _soul.instantiate() 
	add_child.call_deferred(soul)

func refresh_mode():
	staffsprite.texture = staff if global.AnubisMode else scythe
	$AnubisTheme.volume_db = 0 if global.AnubisMode else -80
	$DeathTheme.volume_db = -80 if global.AnubisMode else 0
	$Lava.visible = false if global.AnubisMode else true
	$Sand.visible = true if global.AnubisMode else false
	global.speed = 40 if global.AnubisMode else 60
	_allegiance_icon.texture = anubis_path if global.AnubisMode == true else death_path
	_allegiance_icon.flip_h = true if global.AnubisMode else false
	playersprite.play("anubis" if global.AnubisMode else "death")
	global.souls = 0
	global.sLevel = 1
