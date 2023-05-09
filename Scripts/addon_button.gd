extends Button

signal setActive
var index:int = -1

func _ready():
	pass


func _on_addon_button_button_up():
	emit_signal("setActive", index)
