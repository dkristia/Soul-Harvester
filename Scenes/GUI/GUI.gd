extends Control

@onready var soulLabel = $CanvasLayer/HBoxContainer/MarginContainer/Souls
@onready var global = $"/root/Global"

func _process(delta):
	soulLabel.text = str(global.souls)
