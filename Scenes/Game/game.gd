extends Node2D


# Called when the node enters the scene tree for the first time.
@onready var _soul = preload("res://Objects/Soul/soul.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_soul_spawner_timeout():
	var soul = _soul.instantiate()
	add_child(soul)
