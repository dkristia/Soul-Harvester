extends VBoxContainer


@onready var global = $"/root/Global"

func _process(delta):
	$Good.value = global.good
	$Bad.value = global.bad
