extends Button

signal setActive
var index:int = -1

func _ready():
	pass


func _on_store_item_button_button_up():
	emit_signal("setActive", index)
