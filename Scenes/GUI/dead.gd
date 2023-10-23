extends CanvasLayer

@onready var global = $"/root/Global"


func _process(_delta):
	$Label.text = "Final Score: " + str(global.score)

func _on_button_pressed():
	global.reset_all()
	global.score = 0
	get_tree().change_scene_to_file("res://Scenes/MainMenu/MainMenu.tscn")


func _on_button_2_pressed():
	global.reset_all()
	global.score = 0
	get_tree().quit()
