extends Control

@onready var stick = $CanvasLayer/stick
@onready var holder1 = $CanvasLayer/stick/holder
@onready var holder2 = $CanvasLayer/stick/holder2
@onready var global = $"/root/Global"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.bad > global.good and global.good != 0:
		stick.rotation_degrees = 45 * global.bad/global.good - 45
	elif global.good > global.bad and global.bad != 0:
		stick.rotation_degrees = - 45 * global.good/global.bad + 45
	if stick.rotation_degrees > 45:
		stick.rotation_degrees = 45
	elif stick.rotation_degrees < -45:
		global.dead = true
		stick.rotation_degrees = -45

	holder1.rotation = -stick.rotation
	holder2.rotation = -stick.rotation
	
	
	if Input.is_action_pressed("down"):
		global.good -= 1
	if Input.is_action_pressed("up"):
		global.good += 1
		
	if Input.is_action_pressed("left"):
		global.bad -= 1
	if Input.is_action_pressed("right"):
		global.bad += 1
		
	
	holder1.get_node("Label").text = str(snapped(global.good, 0.01))
	holder2.get_node("Label").text = str(snapped(global.bad, pow(10, -3)))
