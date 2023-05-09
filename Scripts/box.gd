extends StaticBody

export var max_life:int = 100
var life:int = 100

func _ready():
	life = max_life
	pass
	
func take_hit(value = 1):
	life -= value
	$Damage_effect.emitting = true
	if(life < 1):
		queue_free()
		return
