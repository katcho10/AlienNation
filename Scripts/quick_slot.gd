extends TouchScreenButton

var iname:String = "none"
var ID = 0
var type = 0
var count_or_ups = 0
var price = 0
var value:Vector3 = Vector3.ZERO
var description:String = "None"

onready var all_item_icons = $all_icons
onready var count_label = $Label

func _ready():
	pass

func set_dict_buff(dvalue):
	ID = int(dvalue.get("ID"))
	if ID != 0:
		iname = dvalue.get("iname")
		type = int(dvalue.get("type"))
		count_or_ups = int(dvalue.get("count_or_ups"))
		price = int(dvalue.get("price"))
		value = Vector3(dvalue.get("valueX"), dvalue.get("valueY"), dvalue.get("valueZ"))
		description = dvalue.get("description")
		
		all_item_icons.frame = ID
		count_label.text = String(count_or_ups)
	

func convert_to_dict():
	var tmp = {
		"iname" : iname,
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

func _on_Quick_Slot_Button_released():
	GPlayerStatus.restor_status(value)
	count_or_ups -= 1
	
	if(count_or_ups < 1):
		clear_item()
		return
	
	count_label.text = String(count_or_ups)

func clear_item():
	all_item_icons.frame = 0
	count_label.text = ""
	type = 0
	ID = 0
	count_or_ups = 0
	price = 0
	value = Vector3.ZERO
	description = ""

func set_slot(btn_itm):
	if(ID == 0):
		iname = btn_itm.text
		ID = btn_itm.ID
		type = btn_itm.type
		count_or_ups = btn_itm.count_or_ups
		price = btn_itm.price
		value = btn_itm.value
		description = btn_itm.description
		
		all_item_icons.frame = ID
		count_label.text = String(count_or_ups)
		return null

	if(ID == btn_itm.ID):
		count_or_ups += btn_itm.count_or_ups
		count_label.text = String(count_or_ups)
		return null
	

	var tmp_arr = [iname, ID, type, count_or_ups, price, value, description]
	
	iname = btn_itm.text
	ID = btn_itm.ID
	type = btn_itm.type
	count_or_ups = btn_itm.count_or_ups
	price = btn_itm.price
	value = btn_itm.value
	description = btn_itm.description

	all_item_icons.frame = ID
	count_label.text = String(count_or_ups)
	return tmp_arr
	
