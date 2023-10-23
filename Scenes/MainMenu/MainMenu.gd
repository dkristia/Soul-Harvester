extends Control


func _on_button_pressed():
	var menu = load("res://Scenes/StartManu/Menu.tscn").instantiate()
	$CanvasLayer.visible = false
	add_child(menu)


func _on_button_2_pressed():
	var menu = load("res://Scenes/MainMenu/credits.tscn").instantiate()
	$CanvasLayer.visible = false
	add_child(menu)


func _on_button_3_pressed():
	get_tree().quit()
