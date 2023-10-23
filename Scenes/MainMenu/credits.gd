extends Control


func _on_button_pressed():
	get_parent().get_node("CanvasLayer").visible = true
	queue_free()
