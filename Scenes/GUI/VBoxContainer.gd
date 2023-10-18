extends VBoxContainer


@onready var global = $"/root/Global"

func _process(_delta):
	$Good.value = global.good
	$Bad.value = global.bad
