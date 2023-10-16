extends Control

@onready var soulLabel = $CanvasLayer/HBoxContainer/MarginContainer/Souls
@onready var DeathLabel = $CanvasLayer/HBoxContainer/MarginContainer3/De_Anu
@onready var AnubisEyes = $CanvasLayer/HBoxContainer/MarginContainer4/TextureRect
@onready var global = $"/root/Global"

func _process(delta):
	soulLabel.text = str(global.Dsouls) + " - " + str(global.Asouls)
	DeathLabel.text = global.DeathLabel
	AnubisEyes.visible = global.EyesVisible
