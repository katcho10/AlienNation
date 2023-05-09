extends Button

var ID = 0
var type = 0
var count_or_ups = 0
var price = 0
var value:Vector3 = Vector3.ZERO
var description:String = "None"

func _ready():
	set_process(false)
	pass

func on_item_delete():
	queue_free()

func _on_Item_Button_button_up():
	GPlayerInventory.set_item(self)
	
func set_array_buff(rvalue):
	text = rvalue[0]
	ID = rvalue[1]
	type = rvalue[2]
	count_or_ups = rvalue[3]
	price = rvalue[4]
	value = rvalue[5]
	description = rvalue[6]

func set_dict_buff(dvalue):
	text = dvalue.get("iname")
	ID = int(dvalue.get("ID"))
	type = int(dvalue.get("type"))
	count_or_ups = int(dvalue.get("count_or_ups"))
	price = int(dvalue.get("price"))
	value = Vector3(dvalue.get("valueX"), dvalue.get("valueY"), dvalue.get("valueZ"))
	description = dvalue.get("description")

func convert_to_dict():
	var tmp = {
		"iname" : text,
		"ID" : ID,
		"type" : type,
		"count_or_ups" : count_or_ups,
		"price" : price,
		"valueX" : value.x,
		"valueY" : value.y,
		"valueZ" : value.z,
		"description" : description
	}
	return tmp
