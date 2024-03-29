extends Node

@export var DeathLabel = "Death" 
@export var AnubisMode = false
@export var levelModifier = 1
@export var sLevel = 1
@export var dead = false
@export var souls = 0
@export var score = 0
@export var good = 100
@export var bad = 100
@export var radius_multiplier = 1
@export var class_multiplier = 1
@export var ability_radius_multiplier = 1
@export var radius = 1
@export var speed = 40


func _process(_delta):
	class_multiplier = 2 if AnubisMode else 1
	radius = radius_multiplier * class_multiplier * ability_radius_multiplier
	if bad < 0:
		bad = 0
	if good < 0:
		good = 0


func reset_all():
	levelModifier = 1
	sLevel = 1
	dead = false
	souls = 0
	good = 100
	bad = 100
	radius_multiplier = 1
	class_multiplier = 1
	ability_radius_multiplier = 1
	radius = 1
	speed = 40
