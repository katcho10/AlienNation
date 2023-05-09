extends Spatial

var enemies:Array = []

func _ready():
	pass

func _on_Timer_timeout():
	if(not enemies.empty()):
		var tmp_e = enemies.pop_front()
		tmp_e.reset()
