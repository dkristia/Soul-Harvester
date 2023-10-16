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


func _process(delta):
	if bad < 0:
		bad = 0
	if good < 0:
		good = 0
