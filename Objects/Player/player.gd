extends CharacterBody2D

@onready var global = $"/root/Global"

var default_radius = Vector2(1, 1)

var ability_on_cooldown = false
var dashedDistance = 0
var directions

func _ready():
	var spawnpos = get_viewport().get_visible_rect().size/2
	position = spawnpos
	$MainSprite.play("Ddefault")

func _physics_process(delta):
	directions = get_directions()
	
	$PickupRadius.scale = default_radius * global.radius
	
	if Input.get_action_strength("right") or Input.get_action_strength("left") or Input.get_action_strength("down") or Input.get_action_strength("up"):
		playanim()
	velocity = directions * global.speed * delta
	
	if Input.is_action_just_pressed("main_ability") and !ability_on_cooldown:
		_anubis_main_ability() if global.AnubisMode else _death_main_ability()
		ability_on_cooldown = true
		var timer = $MainAbilityCooldown
		timer.wait_time = 10 if global.AnubisMode else 4
		timer.start()
	
	if  Input.is_action_just_pressed("left"):
		$MainSprite.set_flip_h(true)
	elif Input.is_action_just_pressed("right"):
		$MainSprite.set_flip_h(false)

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
	global.speed *= 10
	$DashTimer.start()

func _on_main_cooldown_timeout():
	ability_on_cooldown=false

func playanim():
	if global.AnubisMode:
		$MainSprite.play("Awalking")
		await $MainSprite.animation_finished
		$MainSprite.play("Adefault")
	else:
		$MainSprite.play("Dwalking")
		await $MainSprite.animation_finished
		$MainSprite.play("Ddefault")


func _on_dash_timer_timeout():
	global.speed /= 10
	$DashTimer.stop()
