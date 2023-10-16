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
@export var speed = 20


func _process(_delta):
	speed = 20 if AnubisMode else 40
	class_multiplier = 2 if AnubisMode else 1
	radius = radius_multiplier * class_multiplier * ability_radius_multiplier
	if bad < 0:
		bad = 0
	if good < 0:
		good = 0
