extends Node

enum ITEM_type {
	NONE = 0,
	CONSUMABLE = 1,
	WEAPON_PRI = 2,
	WEAPON_SEC = 3,
	HEADGEAR = 4,
	TORSO_AMR = 5,
	LEGS_AMR = 6,
	BOOTS = 7,
	ACCESSORY = 8,
	ETC = 9
}

var inv_max_item_count:int = 20
var current_item_selected = null

onready var container = $background/ScrollContainer/VBoxContainer
onready var item_button = preload("res://Scenes/HudAndUtilities/Item_Button.tscn")

onready var item_status = $background/Item_Stat_BG
onready var item_stat_name_label = $background/Item_Stat_BG/name_label
onready var item_stat_count_label = $background/Item_Stat_BG/count_label
onready var item_stat_price_label = $background/Item_Stat_BG/price_label
onready var item_stat_icons = $background/Item_Stat_BG/all_icons
onready var item_stat_desc_label = $background/Item_Stat_BG/description_label
onready var item_x_label = $background/Item_Stat_BG/x_prop_label
onready var item_y_label = $background/Item_Stat_BG/y_prop_label
onready var item_z_label = $background/Item_Stat_BG/z_prop_label
onready var legend_restore = $background/Item_Stat_BG/restore_icons
onready var legend_attrib = $background/Item_Stat_BG/attrib_icons

onready var button_add_slot = $background/Item_Stat_BG/add_slot_button
onready var button_use_equip = $background/Item_Stat_BG/use_equip_button

onready var quick_slot = $quick_slot_button


func _ready():
	pass

func hud_clear(rvalue = true):
	if rvalue:
		$inv_button.visible = false
		$save_button.visible = false
		quick_slot.visible = false
	else:
		$inv_button.visible = true
		$save_button.visible = true
		quick_slot.visible = true
	

func on_sell_inventory_item():
	$background/Item_Stat_BG/sell_button.visible = true
	$background/Item_Stat_BG/sell_ten_button.visible = true
	$background/inv_label.text = "Sell"
	$background.visible = true
	$inv_button.visible = false
	$save_button.visible = false
	quick_slot.visible = false
	GPlayerStatus.game_pause()

func _on_inv_button_released():
	$background/Item_Stat_BG/sell_button.visible = false
	$background/Item_Stat_BG/sell_ten_button.visible = false
	$background/inv_label.text = "Inventory"
	$background.visible = true
	$inv_button.visible = false
	$save_button.visible = false
	quick_slot.visible = false
	GPlayerStatus.game_pause()
	$debug_label.text = ""

func _on_close_button_button_up():
	current_item_selected = null
	close_item_status()
	$background.visible = false
	$inv_button.visible = true
	$save_button.visible = true
	quick_slot.visible = true
	GPlayerStatus.game_pause(false)

func new_game_items():
	var tmp1 = item_button.instance()
	tmp1.text = "Bread"
	tmp1.ID = 4
	tmp1.type = ITEM_type.CONSUMABLE
	tmp1.count_or_ups = 20
	tmp1.price = 10
	tmp1.value.x = 20.0
	tmp1.value.y = 5.0
	tmp1.value.z = 0.0
	tmp1.description = "Give`s some goodness. Made of flour, butter, and sugar Taste good when fresh bake"
	container.add_child(tmp1)
	current_item_selected = tmp1
	_on_add_slot_button_button_up()
	
	var tmp2 = item_button.instance()
	tmp2.text = "Kitchen Knife"
	tmp2.ID = 20
	tmp2.type = ITEM_type.WEAPON_PRI
	tmp2.count_or_ups = 0
	tmp2.price = 100
	tmp2.value.x = 10.0
	tmp2.value.y = 0.0
	tmp2.value.z = 2.0
	tmp2.description = "Kitchen utensil cut fresh meat, fish and vegetables"
	container.add_child(tmp2)
	
#	var tmp3 = item_button.instance()
#	tmp3.text = "Combat Knife"
#	tmp3.ID = 20
#	tmp3.type = ITEM_type.WEAPON_PRI
#	tmp3.count_or_ups = 0
#	tmp3.price = 1000
#	tmp3.value.x = 50.0
#	tmp3.value.y = 0.0
#	tmp3.value.z = 10.0
#	tmp3.description = "Use for cutting people and enemy"
#	container.add_child(tmp3)

func consume_item():
	GPlayerStatus.restor_status(current_item_selected.value)
	current_item_selected.count_or_ups -= 1
	
	if(current_item_selected.count_or_ups < 1):
		current_item_selected.on_item_delete()
		current_item_selected = null
		close_item_status()
		return
		
	item_stat_count_label.text = String(current_item_selected.count_or_ups)

func _on_use_equip_button_button_up():
#	if(current_item_selected == null):
#		return
	
	match current_item_selected.type:
		ITEM_type.NONE:
			return
	
		ITEM_type.CONSUMABLE:
			consume_item()
	
		ITEM_type.WEAPON_PRI, ITEM_type.WEAPON_SEC, ITEM_type.HEADGEAR, \
		ITEM_type.TORSO_AMR, ITEM_type.LEGS_AMR, ITEM_type.BOOTS, ITEM_type.ACCESSORY:
			var ret_e = GPlayerStatus.equipments.add_equipment(current_item_selected)
			if(ret_e != null):
				call_deferred("slot_ret_equip", ret_e)
			_on_remove_button_button_up()
			GPlayerStatus.equipments.set_total_equip_stat()

func _on_remove_button_button_up():
#	if(current_item_selected == null):
#		return
	current_item_selected.on_item_delete()
	current_item_selected = null
	close_item_status()

func set_item(item):
	current_item_selected = item
	item_stat_name_label.text = current_item_selected.text
	item_stat_desc_label.text = current_item_selected.description
	item_stat_price_label.text = String(current_item_selected.price)
	
	match current_item_selected.type:
		ITEM_type.NONE:
			return
	
		ITEM_type.CONSUMABLE:
			item_stat_count_label.text = String(current_item_selected.count_or_ups)
			button_add_slot.visible = true
			button_use_equip.text = "Use"
			button_use_equip.visible = true
			item_stat_icons.frame = current_item_selected.ID
			item_x_label.text = String(current_item_selected.value.x)
			item_y_label.text = String(current_item_selected.value.y)
			item_z_label.text = ""
			legend_attrib.visible = false
			legend_restore.visible = true
	
		ITEM_type.WEAPON_PRI, ITEM_type.WEAPON_SEC, ITEM_type.HEADGEAR, \
		ITEM_type.TORSO_AMR, ITEM_type.LEGS_AMR, ITEM_type.BOOTS, ITEM_type.ACCESSORY:
			item_stat_count_label.text = ""
			button_add_slot.visible  = false
			button_use_equip.text = "Equip"
			button_use_equip.visible = true
			item_stat_icons.frame = current_item_selected.ID
			item_x_label.text = String(current_item_selected.value.x)
			item_y_label.text = String(current_item_selected.value.y)
			item_z_label.text = String(current_item_selected.value.z)
			legend_attrib.visible = true
			legend_restore.visible = false
			pass
		
		ITEM_type.ETC:
			item_stat_count_label.text = String(current_item_selected.count_or_ups)
			button_add_slot.visible  = false
			button_use_equip.visible = false
			item_stat_icons.frame = current_item_selected.ID
			item_x_label.text = ""
			item_y_label.text = ""
			item_z_label.text = ""
			legend_attrib.visible = false
			legend_restore.visible = false
			pass
	
	item_status.visible = true

func close_item_status():
	item_status.visible = false
	item_stat_name_label.text = ""
	item_stat_count_label.text = ""

func _on_add_slot_button_button_up():
#	if(current_item_selected == null):
#		return
	var tmp = quick_slot.set_slot(current_item_selected)
	if(tmp != null):
		slot_ret_item(tmp)
		
	current_item_selected.on_item_delete()
	current_item_selected = null
	close_item_status()

func slot_ret_item(value):
	for c in container.get_children():
		if(value[1] == c.ID):
			c.count_or_ups += value[3]
			return
	
	var tmp = item_button.instance()
	tmp.set_array_buff(value)
	container.add_child(tmp)
	return

func slot_ret_equip(value):
	var tmp = item_button.instance()
	tmp.set_array_buff(value)
#	tmp.text = value[0]
#	tmp.ID = value[1]
#	tmp.type = value[2]
#	tmp.count_or_ups = value[3]
#	tmp.price = value[4]
#	tmp.value = value[5]
#	tmp.description = value[6]
	container.add_child(tmp)

func _on_sell_button_button_up():
	match current_item_selected.type:
		ITEM_type.NONE:
			return
			
		ITEM_type.CONSUMABLE, ITEM_type.ETC:
			current_item_selected.count_or_ups -= 1
			GPlayerStatus.add_money(current_item_selected.price)
			if current_item_selected.count_or_ups < 1:
				current_item_selected.on_item_delete()
				current_item_selected = null
				close_item_status()
				return
			item_stat_count_label.text = String(current_item_selected.count_or_ups)
			pass
			
		ITEM_type.WEAPON_PRI, ITEM_type.WEAPON_SEC, ITEM_type.HEADGEAR, \
		ITEM_type.TORSO_AMR, ITEM_type.LEGS_AMR, ITEM_type.BOOTS, ITEM_type.ACCESSORY:
			GPlayerStatus.add_money(current_item_selected.price)
			current_item_selected.on_item_delete()
			current_item_selected = null
			close_item_status()
			pass

func _on_sell_ten_button_button_up():
	match current_item_selected.type:
		ITEM_type.NONE:
			return
			
		ITEM_type.CONSUMABLE, ITEM_type.ETC:
			if current_item_selected.count_or_ups < 10:
				GPlayerStatus.add_money(current_item_selected.price * current_item_selected.count_or_ups)
				current_item_selected.on_item_delete()
				current_item_selected = null
				close_item_status()
				return
				
			current_item_selected.count_or_ups -= 10
			GPlayerStatus.add_money(current_item_selected.price * 10)
			if current_item_selected.count_or_ups < 1:
				current_item_selected.on_item_delete()
				current_item_selected = null
				close_item_status()
				return
			item_stat_count_label.text = String(current_item_selected.count_or_ups)
			pass
			
		ITEM_type.WEAPON_PRI, ITEM_type.WEAPON_SEC, ITEM_type.HEADGEAR, \
		ITEM_type.TORSO_AMR, ITEM_type.LEGS_AMR, ITEM_type.BOOTS, ITEM_type.ACCESSORY:
			GPlayerStatus.add_money(current_item_selected.price)
			current_item_selected.on_item_delete()
			current_item_selected = null
			close_item_status()
			pass

func can_store_item():
	if container.get_child_count() >= inv_max_item_count:
		$debug_label.text = "inventory is full"
		return false
	return true

func add_stackable_item(value):
	for c in container.get_children():
		if(value.ID == c.ID):
			c.count_or_ups += value.count_or_ups
			return true
	
	if not can_store_item():
		return false
	
	var tmp1 = item_button.instance()
	tmp1.text = value.iname
	tmp1.type = value.type
	tmp1.ID = value.ID
	tmp1.count_or_ups = value.count_or_ups
	tmp1.price = value.price
	tmp1.value = value.value
	tmp1.description = value.description
	container.add_child(tmp1)
	return true

#this is a none stackable item
func add_equipment_item(value):
	if not can_store_item():
		return false
		
	var tmp1 = item_button.instance()
	tmp1.text = value.iname
	tmp1.type = value.type
	tmp1.ID = value.ID
	tmp1.count_or_ups = value.count_or_ups
	tmp1.price = value.price
	tmp1.value = value.value
	tmp1.description = value.description
	container.add_child(tmp1)
	return true
# The Order of Properties
#	[0] var iname:String = "None"
#	[1] var ID = 0 and it is equal to frame of Animated sprite
#	[2] var type = 0
#	[3] var count_or_ups = 0
#	[4] var price = 0
#	[5] var value:Vector3 = Vector3.ZERO
# 	[6] var description:String = "None"
func cart_add_stackable(value, count = 1):
	for c in container.get_children():
		if(value[1] == c.ID):
			c.count_or_ups += value[3] * count
			return true
	
	if not can_store_item():
		return false
	
	var tmp1 = item_button.instance()
	tmp1.text = value[0]
	tmp1.ID = value[1]
	tmp1.type = value[2]
	tmp1.count_or_ups = value[3] * count
	tmp1.price = value[4]
	tmp1.value = value[5]
	tmp1.description = value[6]
	container.add_child(tmp1)
	return true

#this is a none stackable item buff
func cart_add_equipment(value):
	if not can_store_item():
		return false
		
	var tmp1 = item_button.instance()
	tmp1.set_array_buff(value)
#	tmp1.text = value[0]
#	tmp1.ID = value[1]
#	tmp1.type = value[2]
#	tmp1.count_or_ups = value[3]
#	tmp1.price = value[4]
#	tmp1.value = value[5]
#	tmp1.description = value[6]
	container.add_child(tmp1)
	return true

#save inventory
func _on_save_button_released():
	GPlayerStatus.on_save()
	
	$debug_label.text = "saving!!!!"
		
	var savegame = File.new()
	savegame.open("user://inventory.txt", File.WRITE)
	
	#quick slot
	var ndata = quick_slot.convert_to_dict()
	savegame.store_line(to_json(ndata))
	
	if container.get_child_count() == 0:
		savegame.close()
		$debug_label.text = "save quick slot even w/o data"
		return
	
	#inventory
	for i in container.get_children():
		var nodedata = i.convert_to_dict()
		savegame.store_line(to_json(nodedata))
	var apath = savegame.get_path_absolute()
	apath = apath.replace("/", "->")
	savegame.close()
	$debug_label.text = apath + " invetory save!!!"

#load inventory
func _on_load_button_released():
	GPlayerStatus.on_load()
	
	$debug_label.text = "loading!!!!"
	var savegame = File.new()
	if !savegame.file_exists("user://inventory.txt"):
		$debug_label.text = "save inventory don`t exist!!!!"
		return
	
	for i in container.get_children():
		i.queue_free()
	
	var line_num = 0	
	savegame.open("user://inventory.txt", File.READ)
	#quick slot
	var ncurrline = parse_json(savegame.get_line())
	quick_slot.set_dict_buff(ncurrline)
	
	#inventory
	while(savegame.get_position() < savegame.get_len()):
		var currentline = parse_json(savegame.get_line())
		if typeof(currentline) == TYPE_DICTIONARY:
			var tmp = item_button.instance()
			tmp.set_dict_buff(currentline)
			container.add_child(tmp)
		else:
			$debug_label.text = "error loading inventory item number: " + String(line_num)
		
		line_num += 1
	savegame.close()
	$debug_label.text = "load complete!!"
