extends CharacterBody2D

@export var speed = 20

func _ready():
	position = get_viewport().get_visible_rect().size/2

func _physics_process(delta):
	var directions = get_directions()
	
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
			dirx = directions.x / abs(directions.y) * sqrt(2)/2
		else:
			dirx = abs(directions.x/directions.y) * sqrt(2)/2
		if directions.y < 0:
			diry = abs(directions.x) / directions.y * sqrt(2)/2
		else:
			diry = abs(directions.x/directions.y) * sqrt(2)/2
		directions.x = dirx
		directions.y = diry
	directions *= 1000
	return directions


func _on_pickup_radius_area_entered(area):
	if area.is_in_group("soul"):
		area.queue_free()
