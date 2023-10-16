extends CharacterBody2D

@onready var global = $"/root/Global"

var default_radius = Vector2(1, 1)

var DashAvailable = true
var dashedDistance = 0

func _ready():
	var spawnpos = get_viewport().get_visible_rect().size/2
	position = spawnpos
	

func _physics_process(delta):
	var directions = get_directions()
	
	$PickupRadius.scale = default_radius * global.radius
	
	if Input.is_action_just_pressed("main_ability"):
		_anubis_main_ability() if global.AnubisMode else _death_main_ability()
	
	velocity = directions * global.speed * delta
	
	if Input.is_action_pressed("Dash") and DashAvailable:
		velocity = directions * global.speed * 2 * delta
		dashedDistance += 45 * delta
		
		if dashedDistance > 10:
			DashAvailable = false
			
			var timer = $Dashimer
			timer.wait_time = 4
			timer.start()
	elif Input.is_action_just_released("Dash") and DashAvailable:
			DashAvailable = false
			
			var timer = $Dashimer
			timer.wait_time = 4
			timer.start()
			
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

func _anubis_main_ability():
	if !$PickupRadius.activated:
		global.ability_radius_multiplier = 10
		$PickupRadius.activated = true
	
func _death_main_ability():
	print("DEATH")

func _on_dashimer_timeout():
	DashAvailable=true
	dashedDistance=0
