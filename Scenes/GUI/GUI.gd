extends Control

@onready var soulLabel = $CanvasLayer/HBoxContainer/MarginContainer/Souls
@onready var DeathLabel = $CanvasLayer/MarginContainer3/De_Anu
@onready var scoreLabel = $CanvasLayer/MarginContainer6/Label2
@onready var sellLevel = $CanvasLayer/MarginContainer5/Label
@onready var global = $"/root/Global"
@onready var AnubisPixelart = $"CanvasLayer/TextureRect"
@onready var DeathPixelart = $"CanvasLayer/MarginContainer7/TextureRect2"

func _process(_delta):
	soulLabel.text = str(global.souls)
	scoreLabel.text = "score: " + str(global.score)
	sellLevel.text = "current sell level: " + str(global.sLevel)

	if global.AnubisMode:
		DeathLabel.text = "Servant of the ancient Anubis"
	else:
		DeathLabel.text = "Servant of the mighty Death"
		
	if global.AnubisMode:
		AnubisPixelart.visible=true
		DeathPixelart.visible=false
	else:
		AnubisPixelart.visible=false
		DeathPixelart.visible=true
