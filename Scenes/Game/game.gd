extends Node2D


# Called when the node enters the scene tree for the first time.
@onready var _soul = preload("res://Objects/Soul/soul.tscn")
@onready var global = $"/root/Global"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("Anubis"):
		global.AnubisMode = true
		global.DeathLabel = "Anubis"
	if Input.is_action_pressed("Death"):
		global.AnubisMode = false
		global.DeathLabel = "Death"
	
func _on_soul_spawner_timeout():
	var soul = _soul.instantiate()
	add_child(soul)
