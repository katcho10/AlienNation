extends Area

var value:int = 1

onready var col_shape = $CollisionShape
onready var timex = $Timer

func _ready():
	pass


func _on_Timer_timeout():
	queue_free()

func _on_gold_area_body_entered(_body):
	col_shape.disabled = true
	visible = false
	GPlayerStatus.add_money(value)
	timex.stop()
	timex.start(3)
