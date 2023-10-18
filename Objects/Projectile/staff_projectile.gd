extends Area2D

@export var target = Vector2(0, 0)
@onready var global = $"/root/Global"
var reached = false

func _process(delta):
	rotation_degrees += 1500 * delta
	if !reached:
		position = position.move_toward(target, 1500*delta)
		if round(position) == round(target):
			reached = true
	else:
		position = position.move_toward(get_parent().get_node("Player").position, 1500*delta)
	if position == get_parent().get_node("Player").position:
		get_parent().get_node("Player").get_node("Staff").modulate.a = 100
		queue_free()


func _on_area_entered(area):
	if area.is_in_group("human"):
		area.call_deferred("kill")
		global.bad += 1
