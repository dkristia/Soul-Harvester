extends Node

@export var DeathLabel = "Death" 
@export var AnubisMode = false
@export var Asouls = 0
@export var Dsouls = 0
@export var good = 1
@export var bad = 1

func _process(delta):
	if bad < 0:
		bad = 0
	if good < 0:
		good = 0
