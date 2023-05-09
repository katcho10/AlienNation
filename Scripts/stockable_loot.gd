extends Area

var iname:String = "None"
var ID = 0
var type = 0
var count_or_ups = 0
var price = 0
var value:Vector3 = Vector3.ZERO
var description:String = "None"

onready var col_shape = $CollisionShape
onready var timex = $Timer

func _ready():
	$MeshInstance.rotate_y(rand_range(0, 6.28218))

func _on_Area_body_entered(_body):
	if(GPlayerInventory.add_stackable_item(self)):
		col_shape.disabled = true
		visible = false
		timex.stop()
		timex.start(3)

func _on_Timer_timeout():
	queue_free()

func set_array_buff(rvalue):
	iname = rvalue[0]
	ID = rvalue[1]
	type = rvalue[2]
	count_or_ups = rvalue[3]
	price = rvalue[4]
	value = rvalue[5]
	description = rvalue[6]