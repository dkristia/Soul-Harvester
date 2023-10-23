extends CharacterBody2D

@onready var global = $"/root/Global"
@onready var game = get_parent()
@onready var staff_projectile = preload("res://Objects/Projectile/staff_projectile.tscn")
@onready var _flash = preload("res://Scenes/Game/flash.tscn")

var default_radius = Vector2(1, 1)

var ability_on_cooldown = false
var sec_ability_on_cooldown = false
var dashedDistance = 0
var directions
var dashing = false
var startpos = Vector2(0, 0)
var dashpos = Vector2(0, 0)

func _ready():
	var spawnpos = get_viewport().get_visible_rect().size/2
	position = spawnpos
	game._ready()

func _physics_process(delta):
	get_directions()
	
	$PickupRadius.scale = default_radius * global.radius
	
	if Input.get_action_strength("right") or Input.get_action_strength("left") or Input.get_action_strength("down") or Input.get_action_strength("up"):
		animate_walking()
	
	if dashing:
		position = position.move_toward(dashpos, 5000*delta)
		if position == dashpos:
			global.ability_radius_multiplier = 1
			dashing = false
	
	velocity = directions * global.speed * delta
	
	if Input.is_action_just_pressed("main_ability") and !ability_on_cooldown:
		anubis_main_ability() if global.AnubisMode else death_main_ability()
		ability_on_cooldown = true
		var timer = $MainAbilityCooldown
		timer.wait_time = 10 if global.AnubisMode else 10
		timer.start()

	if Input.is_action_just_pressed("secondary_ability") and !sec_ability_on_cooldown:
		anubis_secondary_ability() if global.AnubisMode else death_secondary_ability()
		sec_ability_on_cooldown = true
		var timer = $SecondaryCooldown
		timer.wait_time = 20 if global.AnubisMode else 4
		timer.start()
	
	
	if  Input.is_action_just_pressed("left"):
		$MainSprite.set_flip_h(true)
	elif Input.is_action_just_pressed("right"):
		$MainSprite.set_flip_h(false)
		
	if position.x > 3700:
		position.x = 3700
	elif position.x < -3700:
		position.x = -3700
	if position.y > 3700:
		position.y = 3700
	elif position.y < -3700:
		position.y = -3700

	move_and_slide()
	
func get_directions():
	directions = Vector2(
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

func anubis_main_ability():
	if !$PickupRadius.activated:
		global.ability_radius_multiplier = 10
		$PickupRadius.activated = true

func anubis_secondary_ability():
	var flash = _flash.instantiate()
	get_parent().get_node("GUI").add_child(flash)
	get_parent().time -= get_parent().time * 0.5
	for human in get_parent().get_children():
		if human.is_in_group("human"):
			randomize()
			var rand = randf_range(0, 100)
			if rand <= 50:
				human.call_deferred("kill")

func death_main_ability():
	var staff = staff_projectile.instantiate()
	staff.target = get_global_mouse_position()
	staff.position = position
	staff.target = position + (staff.target-position).normalized() * 2000
	add_sibling(staff)
	$Staff.modulate.a = 0

func death_secondary_ability():
	dashing = true
	global.ability_radius_multiplier = 2
	startpos = position
	dashpos = get_global_mouse_position()
	if position.distance_to(dashpos) > 1500:
		dashpos = position + (dashpos-position).normalized() * 1500

func animate_walking():
	if global.AnubisMode:
		$MainSprite.play("a_walk")
		await $MainSprite.animation_finished
		$MainSprite.play("anubis")
	else:
		$MainSprite.play("d_walk")
		await $MainSprite.animation_finished
		$MainSprite.play("death")

func _on_main_cooldown_timeout():
	ability_on_cooldown = false

func _on_pickup_radius_area_entered(area):
	if area.is_in_group("soul"):
		area.pickup_pos = area.position
		area.picked_up = true
	elif area.is_in_group("human") and dashing:
		area.call_deferred("kill")
		global.good -= 1

func _on_inner_pickup_radius_area_entered(area):
	if area.is_in_group("soul"):
		global.souls += 1
		if global.souls == 5 * global.sLevel ** 2:
			global.sLevel += 1
		area.queue_free()


func _on_secondary_cooldown_timeout():
	sec_ability_on_cooldown = false
