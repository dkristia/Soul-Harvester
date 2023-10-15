extends Control

@onready var goodbox = $CanvasLayer/HBoxContainer/Good
@onready var badbox = $CanvasLayer/HBoxContainer/Bad
@onready var global = $"/root/Global"

	
func _process(delta):
	if Input.is_action_pressed("down"):
		global.good -= 0.01
	if Input.is_action_pressed("up"):
		global.good += 0.01
		
	if Input.is_action_pressed("left"):
		global.bad -= 0.01
	if Input.is_action_pressed("right"):
		global.bad += 0.01
	
	var good = global.good
	var bad = global.bad
	
	if good > bad:
		var difference = good/bad * 100
		goodbox.add_theme_constant_override("margin_bottom", difference)
		badbox.add_theme_constant_override("margin_top", difference)
	elif bad > good:
		var difference = bad/good * 100
		goodbox.add_theme_constant_override("margin_top", difference)
		badbox.add_theme_constant_override("margin_bottom", difference)
	else:
		goodbox.add_theme_constant_override("margin_top", 0)
		goodbox.add_theme_constant_override("margin_bottom", 0)
		badbox.add_theme_constant_override("margin_top", 0)
		badbox.add_theme_constant_override("margin_bottom", 0)
