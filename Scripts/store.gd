extends Area

export var store_name = "Bakery"
export var store_profit = 20
export var is_buying = true
export(Resource) var goods
onready var store_item = preload("res://Scenes/HudAndUtilities/Store_Item_Button.tscn")

onready var front_menu = $CanvasLayer/Front_Store_BG
onready var container = $CanvasLayer/Store_BG/ScrollContainer/VBoxContainer

onready var debug_label = $CanvasLayer/Store_BG/debug_label
onready var item_status = $CanvasLayer/Store_BG/Item_Stat_BG
onready var item_stat_name_label = $CanvasLayer/Store_BG/Item_Stat_BG/name_label
onready var item_stat_count_label = $CanvasLayer/Store_BG/Item_Stat_BG/count_label
onready var item_stat_price_label = $CanvasLayer/Store_BG/Item_Stat_BG/price_label
onready var item_stat_icons = $CanvasLayer/Store_BG/Item_Stat_BG/all_icons
onready var item_stat_desc_label = $CanvasLayer/Store_BG/Item_Stat_BG/description_label
onready var item_x_label = $CanvasLayer/Store_BG/Item_Stat_BG/x_prop_label
onready var item_y_label = $CanvasLayer/Store_BG/Item_Stat_BG/y_prop_label
onready var item_z_label = $CanvasLayer/Store_BG/Item_Stat_BG/z_prop_label
onready var legend_restore = $CanvasLayer/Store_BG/Item_Stat_BG/restore_icons
onready var legend_attrib = $CanvasLayer/Store_BG/Item_Stat_BG/attrib_icons

onready var buy_ten_button = $CanvasLayer/Store_BG/Item_Stat_BG/buy_ten_button

var selected = -1

func _ready():
	$CanvasLayer/Front_Store_BG/Label.text = store_name
	$CanvasLayer/Store_BG/Label.text = store_name
	
	if(not is_buying):
		$CanvasLayer/Front_Store_BG/sell_button.visible = false

	$MeshInstance.call_deferred("queue_free")

func _on_area_body_entered(_body):
	front_menu.visible = true

func _on_area_body_exited(_body):
	front_menu.visible = false

func _on_sell_button_button_up():
	front_menu.visible = false
	GPlayerInventory.on_sell_inventory_item()

# The Order of Properties
#	[0] var iname:String = "None"
#	[1] var ID = 0 and it is equal to frame of Animated sprite
#	[2] var type = 0
#	[3] var count_or_ups = 0
#	[4] var price = 0
#	[5] var value:Vector3 = Vector3.ZERO
# 	[6] var description:String = "None"
func _on_select_store_item(index):
	debug_label.text = ""
	selected = index
	item_stat_name_label.text = goods.stocks[selected][0]
	item_stat_desc_label.text = goods.stocks[selected][6]
	item_stat_price_label.text = String(goods.stocks[selected][4] + store_profit)

	match goods.stocks[selected][2]:
		GPlayerInventory.ITEM_type.NONE:
			return

		GPlayerInventory.ITEM_type.CONSUMABLE:
			item_stat_count_label.text = String(goods.stocks[selected][3])
			item_stat_icons.frame = goods.stocks[selected][1]
			item_x_label.text = String(goods.stocks[selected][5].x)
			item_y_label.text = String(goods.stocks[selected][5].y)
			item_z_label.text = ""
			legend_attrib.visible = false
			legend_restore.visible = true
			buy_ten_button.visible = true
			pass

		GPlayerInventory.ITEM_type.WEAPON_PRI, GPlayerInventory.ITEM_type.WEAPON_SEC, \
		GPlayerInventory.ITEM_type.HEADGEAR, GPlayerInventory.ITEM_type.TORSO_AMR, \
		GPlayerInventory.ITEM_type.LEGS_AMR, GPlayerInventory.ITEM_type.BOOTS, GPlayerInventory.ITEM_type.ACCESSORY:
			item_stat_count_label.text = ""
			item_stat_icons.frame = goods.stocks[selected][1]
			item_x_label.text = String(goods.stocks[selected][5].x)
			item_y_label.text = String(goods.stocks[selected][5].y)
			item_z_label.text = String(goods.stocks[selected][5].z)
			legend_attrib.visible = true
			legend_restore.visible = false
			buy_ten_button.visible = false
			pass

		GPlayerInventory.ITEM_type.ETC:
			item_stat_count_label.text = String(goods.stocks[selected][3])
			item_stat_icons.frame = goods.stocks[selected][1]
			item_x_label.text = ""
			item_y_label.text = ""
			item_z_label.text = ""
			legend_attrib.visible = false
			legend_restore.visible = false
			buy_ten_button.visible = true
			pass

	item_status.visible = true

func _on_store_close_button_button_up():
	debug_label.text = ""
	item_status.visible = false
	$CanvasLayer/Store_BG.visible = false
	for s in container.get_children():
		s.queue_free()
	GPlayerInventory.hud_clear(false)
	GPlayerStatus.movement_control_hide(false)
	
func _on_buy_button_button_up():
	for si in range(0, goods.get_stocks_count()):
		var tmp = store_item.instance()
		tmp.text = goods.stocks[si][0]
		tmp.index = si
		container.add_child(tmp)
		tmp.connect("setActive", self, "_on_select_store_item")
	
	front_menu.visible = false
	$CanvasLayer/Store_BG.visible = true
	GPlayerInventory.hud_clear()
	GPlayerStatus.movement_control_hide()


func _on_buy_one_button_button_up():
	var total_amount = goods.stocks[selected][4] + store_profit
	match goods.stocks[selected][2]:
		GPlayerInventory.ITEM_type.NONE:
			return
		GPlayerInventory.ITEM_type.CONSUMABLE, GPlayerInventory.ITEM_type.ETC:
			if GPlayerStatus.money >= total_amount:
				if GPlayerInventory.cart_add_stackable(goods.stocks[selected]):
					GPlayerStatus.decrease_money(total_amount)
				else:
					$CanvasLayer/Store_BG/debug_label.text = "Inventory is full"
			pass
		GPlayerInventory.ITEM_type.WEAPON_PRI, GPlayerInventory.ITEM_type.WEAPON_SEC, \
		GPlayerInventory.ITEM_type.HEADGEAR, GPlayerInventory.ITEM_type.TORSO_AMR, \
		GPlayerInventory.ITEM_type.LEGS_AMR, GPlayerInventory.ITEM_type.BOOTS, GPlayerInventory.ITEM_type.ACCESSORY:
			if GPlayerStatus.money >= goods.stocks[selected][4] + store_profit:
				if GPlayerInventory.cart_add_equipment(goods.stocks[selected]):
					GPlayerStatus.decrease_money(goods.stocks[selected][4] + store_profit)
				else:
					$CanvasLayer/Store_BG/debug_label.text = "Inventory is full"
			pass

			
func _on_buy_ten_button_button_up():
	var total_amount = (goods.stocks[selected][4] + store_profit) * 10
	if GPlayerStatus.money >= total_amount:
		if GPlayerInventory.cart_add_stackable(goods.stocks[selected], 10):
			GPlayerStatus.decrease_money(total_amount)
		else:
			$CanvasLayer/Store_BG/debug_label.text = "Inventory is full"
