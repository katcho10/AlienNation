extends Area

export var shop_name = "Kurimaw Metals"
export(Resource) var addon_pool
onready var addon_button = preload("res://Scenes/HudAndUtilities/Addon_Button.tscn")

onready var shop_menu = $CanvasLayer/Front_Shop_BG
onready var shop_bg = $CanvasLayer/Shop_BG
onready var container = $CanvasLayer/Shop_BG/ScrollContainer/VBoxContainer

onready var debug_label = $CanvasLayer/Shop_BG/debug_label
onready var addon_status = $CanvasLayer/Shop_BG/Addon_Stat_BG
onready var addon_stat_name_label = $CanvasLayer/Shop_BG/Addon_Stat_BG/name_label
onready var addon_stat_fee_label = $CanvasLayer/Shop_BG/Addon_Stat_BG/fee_label
onready var addon_stat_icons = $CanvasLayer/Shop_BG/Addon_Stat_BG/all_skill_icons
onready var addon_stat_desc_label = $CanvasLayer/Shop_BG/Addon_Stat_BG/description_label
onready var addon_stat_en_req_label = $CanvasLayer/Shop_BG/Addon_Stat_BG/en_req_label


var selected = -1

func _ready():
	$CanvasLayer/Front_Shop_BG/Label.text = shop_name

	$MeshInstance.call_deferred("queue_free")

func _on_area_body_entered(_body):
	shop_menu.visible = true

func _on_area_body_exited(_body):
	shop_menu.visible = false
	
func _on_install_button_button_up():
	if not GPlayerStatus.money >= addon_pool.Addons[selected][8]:
		debug_label.text = "not enough zen"
		return
	
	var result = GPlayerStatus.skill_manager.add_skill(addon_pool.Addons[selected])
	match result:
		-1:
			debug_label.text = "no vacant slot!"
		0:
			GPlayerStatus.decrease_money(addon_pool.Addons[selected][8])
			debug_label.text = "addons installed"
		1:
			debug_label.text = "addons already exist!"
		_:
			debug_label.text = "error!!!..."

#[0-> ID, 1-> type, 2-> cooldown, 3-> damage, 4-> req_energy,
#5-> effect:String,
#6-> name:String,
#7-> description:String
#8-> installation fee
#],
func _on_select_addon(index):
	selected = index
	addon_stat_icons.frame = addon_pool.Addons[selected][0]
	addon_stat_en_req_label.text = String(addon_pool.Addons[selected][4])
	addon_stat_name_label.text = addon_pool.Addons[selected][6]
	addon_stat_desc_label.text = addon_pool.Addons[selected][7]
	addon_stat_fee_label.text = String(addon_pool.Addons[selected][8])
	addon_status.visible = true
	pass

func _on_shop_close_button_button_up():
	debug_label.text = ""
	addon_status.visible = false
	shop_bg.visible = false
	for s in container.get_children():
		s.queue_free()
	GPlayerInventory.hud_clear(false)
	GPlayerStatus.movement_control_hide(false)
	pass # Replace with function body.


func _on_addons_button_button_up():
	for a in range(0, addon_pool.get_addons_count()):
		var tmp = addon_button.instance()
		tmp.text = addon_pool.Addons[a][6]
		tmp.index = a
		container.add_child(tmp)
		tmp.connect("setActive", self, "_on_select_addon")
	
	shop_menu.visible = false
	shop_bg.visible = true
	GPlayerInventory.hud_clear()
	GPlayerStatus.movement_control_hide()
	pass # Replace with function body.
	


func _on_rem_slot_button_button_up():
	GPlayerStatus.skill_manager.clear_slot(0)


func _on_rem_slot_button2_button_up():
	GPlayerStatus.skill_manager.clear_slot(1)


func _on_rem_slot_button3_button_up():
	GPlayerStatus.skill_manager.clear_slot(2)
