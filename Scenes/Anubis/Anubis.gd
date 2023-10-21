extends Control

@onready var stick = $handle/stick
@onready var holder1 = $handle/stick/holder
@onready var holder2 = $handle/stick/holder2
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
