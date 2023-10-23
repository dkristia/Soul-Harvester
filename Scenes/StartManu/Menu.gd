extends Control

@onready var global = $"/root/Global"

func _on_button_pressed():
	global.AnubisMode = false
	get_tree().change_scene_to_file("res://Scenes/Game/game.tscn")


func _on_button2_pressed():
	global.AnubisMode = true
	get_tree().change_scene_to_file("res://Scenes/Game/game.tscn")
