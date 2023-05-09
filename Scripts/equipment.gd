extends TextureRect


onready var equip_info_bg = $Item_Stat_BG

# The Order of Properties
#	[0] var iname:String = "None"
#	[1] var ID = 0 and it is equal to frame of Animated sprite
#	[2] var type = 0
#	[3] var count_or_ups = 0
#	[4] var price = 0
#	[5] var value:Vector3 = Vector3.ZERO
# 	[6] var description:String = "None"

var equipments = [
["None", 0, 0, 0, 0, Vector3(0.0, 0.0, 0.0), "None"],
["None", 0, 0, 0, 0, Vector3(0.0, 0.0, 0.0), "None"],
["None", 0, 0, 0, 0, Vector3(0.0, 0.0, 0.0), "None"],
["None", 0, 0, 0, 0, Vector3(0.0, 0.0, 0.0), "None"],
["None", 0, 0, 0, 0, Vector3(0.0, 0.0, 0.0), "None"],
["None", 0, 0, 0, 0, Vector3(0.0, 0.0, 0.0), "None"],
["None", 0, 0, 0, 0, Vector3(0.0, 0.0, 0.0), "None"]
]

var equipment_attack:int = 0
var equipment_power:int = 0
var equipment_armor:float = 0.0

var curr_equipment:int =-1

func initialize():
	var tmpD = GPlayerStatus.attack_damage + equipment_attack
	var tmpP = GPlayerStatus.power_damage + equipment_power
	var tmpA = GPlayerStatus.armor + equipment_armor
	$Item_Stat_BG/x_total_label.text = String(tmpD)
	$Item_Stat_BG/y_total_label.text = String(tmpP)
	$Item_Stat_BG/z_total_label.text = String(tmpA)
	visible = true

func convert_to_dict(rvalue):
	var tmp = {
		"iname" : rvalue[0],
		"ID" : rvalue[1],
		"type" : rvalue[2],
		"count_or_ups" : rvalue[3],
		"price" : rvalue[4],
		"valueX" : rvalue[5].x,
		"valueY" : rvalue[5].y,
		"valueZ" : rvalue[5].z,
		"description" : rvalue[6]
	}
	return tmp

func set_equipments_dict_buff(indx, dvalue):
	equipments[indx][0] = dvalue.get("iname")
	equipments[indx][1] = int(dvalue.get("ID"))
	equipments[indx][2] = int(dvalue.get("type"))
	equipments[indx][3] = int(dvalue.get("count_or_ups"))
	equipments[indx][4] = int(dvalue.get("price"))
	equipments[indx][5] = Vector3(dvalue.get("valueX"), dvalue.get("valueY"), dvalue.get("valueZ"))
	equipments[indx][6] = dvalue.get("description")
	
func clear_slot(slot):
	equipments[slot][0] = "None"
	equipments[slot][1] = 0
	equipments[slot][2] = 0
	equipments[slot][3] = 0
	equipments[slot][4] = 0
	equipments[slot][5] = Vector3.ZERO
	equipments[slot][6] = "None"
	
func set_total_equip_stat():
	equipment_attack = 0
	equipment_power = 0
	equipment_armor = 0.0
	for e in equipments:
		equipment_attack += int(e[5].x)
		equipment_power += int(e[5].y)
		equipment_armor += e[5].z
		

func set_equip_status():
	var tmpV = equipments[curr_equipment][5]
	var Sattack = String(GPlayerStatus.attack_damage) + " + " + String(tmpV.x)
	var Smagic = String(GPlayerStatus.power_damage) + " + " + String(tmpV.y)
	var Sarmor = String(GPlayerStatus.armor) + " + " + String(tmpV.z)
	$Item_Stat_BG/x_prop_label.text = Sattack
	$Item_Stat_BG/y_prop_label.text = Smagic
	$Item_Stat_BG/z_prop_label.text = Sarmor
	
	$Item_Stat_BG/name_label.text = equipments[curr_equipment][0]
	$Item_Stat_BG/all_icons.frame = equipments[curr_equipment][1]
	$Item_Stat_BG/ups_label.text = "upgrades: " + String(equipments[curr_equipment][3])
	$Item_Stat_BG/description_label.text = equipments[curr_equipment][6]
	equip_info_bg.visible = true

func add_equipment(rvalue):
	var tmpIndex = rvalue.type - 2
	if equipments[tmpIndex][2] <= 0:
		equipments[tmpIndex][0] = rvalue.text
		equipments[tmpIndex][1] = rvalue.ID
		equipments[tmpIndex][2] = rvalue.type
		equipments[tmpIndex][3] = rvalue.count_or_ups
		equipments[tmpIndex][4] = rvalue.price
		equipments[tmpIndex][5] = rvalue.value
		equipments[tmpIndex][6] = rvalue.description
		
		return null
	else:
		#GPlayerInventory.slot_ret_equip(equipments[tmpIndex])
		var tmpr = [
		equipments[tmpIndex][0],
		equipments[tmpIndex][1],
		equipments[tmpIndex][2],
		equipments[tmpIndex][3],
		equipments[tmpIndex][4],
		equipments[tmpIndex][5],
		equipments[tmpIndex][6]
		]
		
		equipments[tmpIndex][0] = rvalue.text
		equipments[tmpIndex][1] = rvalue.ID
		equipments[tmpIndex][2] = rvalue.type
		equipments[tmpIndex][3] = rvalue.count_or_ups
		equipments[tmpIndex][4] = rvalue.price
		equipments[tmpIndex][5] = rvalue.value
		equipments[tmpIndex][6] = rvalue.description
		
		return tmpr


func _on_close_button_button_up():
	GPlayerStatus.movement_control_hide(false)
	GPlayerInventory.hud_clear(false)
	curr_equipment = -1
	equip_info_bg.visible = false
	visible = false

func _on_headgear_button_button_up():
	curr_equipment = 2
	set_equip_status()

func _on_weapon_one_button_button_up():
	curr_equipment = 0
	set_equip_status()

func _on_weapon_two_button_button_up():
	curr_equipment = 1
	set_equip_status()

func _on_torso_amr_button_button_up():
	curr_equipment = 3
	set_equip_status()

func _on_legs_amr_button_button_up():
	curr_equipment = 4
	set_equip_status()

func _on_boots_button_button_up():
	curr_equipment = 5
	set_equip_status()

func _on_accessory_button_button_up():
	curr_equipment = 6
	set_equip_status()

func _on_remove_button_button_up():
	if curr_equipment <= -1:
		return
	
	if equipments[curr_equipment][2] > 0:
		GPlayerInventory.slot_ret_equip(equipments[curr_equipment])
	equip_info_bg.visible = false
	clear_slot(curr_equipment)
	curr_equipment = -1
	set_total_equip_stat()
	initialize()

func on_save():
	var savegame = File.new()
	savegame.open("user://equipment.txt", File.WRITE)
	
	#equipment
	for e in equipments:
		var nodedata = convert_to_dict(e)
		savegame.store_line(to_json(nodedata))

	savegame.close()
	print("save equipment")
	
func on_load():
	var savegame = File.new()
	if !savegame.file_exists("user://equipment.txt"):
		print("equipment save don`t exist!!!")
		return
		
	savegame.open("user://equipment.txt", File.READ)
	
	#equipment
	var index = 0
	while(savegame.get_position() < savegame.get_len()):
		var currentline = parse_json(savegame.get_line())
		if typeof(currentline) == TYPE_DICTIONARY:
			set_equipments_dict_buff(index, currentline)
			index += 1
		else:
			print("error loading equipment")
	
	savegame.close()
	set_total_equip_stat()
	print("load equipment")
