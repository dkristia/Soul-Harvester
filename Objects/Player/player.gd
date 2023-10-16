extends CharacterBody2D

@export var speed = 20
@onready var global = $"/root/Global"

func _ready():
	var spawnpos = get_viewport().get_visible_rect().size/2
	position = spawnpos
	

func _physics_process(delta):
	var directions = get_directions()
	
	$Staff.look_at(get_global_mouse_position())
	
	if $Staff.rotation_degrees >= 270:
		$Staff.rotation_degrees -= 360
	elif $Staff.rotation_degrees <= -270:
		$Staff.rotation_degrees += 360
		
	
	if 90 > $Staff.rotation_degrees and $Staff.rotation_degrees > -90:
		$Staff.scale.y = abs($Staff.scale.y)
	else:
		$Staff.scale.y = -abs($Staff.scale.y)
	
	velocity = directions * speed * delta
	
	move_and_slide()
	
	
	
	
func get_directions():
	var directions = Vector2(
		(Input.get_action_strength("right") - Input.get_action_strength("left")), 
		(Input.get_action_strength("down") - Input.get_action_strength("up"))
	)
	
	if abs(directions).x + abs(directions.y) >= sqrt(2):
		var dirx
		var diry
		if directions.x < 0:
			dirx = directions.x / abs(directions.y) * sin(PI/4)
		else:
			dirx = abs(directions.x/directions.y) * sin(PI/4)
		if directions.y < 0:
			diry = abs(directions.x) / directions.y * sin(PI/4)
		else:
			diry = abs(directions.x/directions.y) * sin(PI/4)
		directions.x = dirx
		directions.y = diry
	directions *= 1000
	return directions


func _on_pickup_radius_area_entered(area):
	if area.is_in_group("soul"):
		area.pickup_pos = area.position
		area.picked_up = true


func _on_inner_pickup_radius_area_entered(area):
	if area.is_in_group("soul"):
		global.souls += 1
		if global.souls == 5 * global.sLevel ** 2:
			global.sLevel += 1
		area.queue_free()
