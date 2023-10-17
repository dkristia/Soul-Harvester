extends Control

@onready var soulLabel = $CanvasLayer/SoulContainer/SoulLabel
@onready var DeathLabel = $CanvasLayer/EyeContainer/Allegiance/De_Anu
@onready var scoreLabel = $CanvasLayer/LeftBox/Score/ScoreLabel
@onready var sellLevel = $CanvasLayer/LeftBox/SellLevel/LevelLabel
@onready var global = $"/root/Global"


func _process(_delta):
	soulLabel.text = str(global.souls)
	scoreLabel.text = "Score: " + str(global.score)
	sellLevel.text = "Current sell level: " + str(global.sLevel)

	DeathLabel.text = "Servant of the " + ("ancient Anubis" if global.AnubisMode else "mighty Death")
