extends Spatial

#iname, ID, type, count, price, (value as Vector3), description

export(Resource) var Pool_Item
var meds_count:int = 0
var foods_count:int = 0
var drinks_count:int = 0
var etc_count:int = 0
var weapon_count:int = 0
var armor_count:int = 0

var gold_loot = preload("res://Scenes/Lootables/Gold_Loots.tscn")
var med_loot = preload("res://Scenes/Lootables/Medicine_Loots.tscn")
var foo_loot = preload("res://Scenes/Lootables/Food_Loots.tscn")
var etc_loot = preload("res://Scenes/Lootables/Etc_Loots.tscn")
var drnk_loot = preload("res://Scenes/Lootables/Drink_Loots.tscn")
var equip_loot = preload("res://Scenes/Lootables/Equipment_Loots.tscn")

export var gold_max_aquired = 50
var gold_min_aquired = 10
#
var drop_offset:Vector3 = Vector3.ZERO
var drop_location:Vector3 = Vector3.ZERO

func _ready():
	gold_min_aquired  = round(gold_max_aquired * 0.5)
	randomize()
	GPlayerStatus.initialized_player(self)
	drop_offset.y = 0.05
	drop_offset.x = rand_range(-1, 1.8)
	drop_offset.z = rand_range(-1.5, 1)


func set_etc_drop():
	var tmp_etc = etc_loot.instance()
	tmp_etc.set_array_buff(Pool_Item.OtherItems[etc_count])
	add_child(tmp_etc)
	tmp_etc.global_translate(drop_location + drop_offset)

	etc_count += 1
	if(etc_count >= Pool_Item.OtherItems.size()):
		etc_count = 0
	
func set_medicine_drop():
	var tmp_med = med_loot.instance()
	tmp_med.set_array_buff(Pool_Item.Medicines[meds_count])
	add_child(tmp_med)
	tmp_med.global_translate(drop_location + drop_offset)

	meds_count += 1
	if(meds_count >= Pool_Item.Medicines.size()):
		meds_count = 0

func set_food_drop():
	var tmp_foo = foo_loot.instance()
	tmp_foo.set_array_buff(Pool_Item.Foods[foods_count])
	add_child(tmp_foo)
	tmp_foo.global_translate(drop_location + drop_offset)

	foods_count += 1
	if(foods_count >= Pool_Item.Foods.size()):
		foods_count = 0
		
func set_drinks_drop():
	var tmp_drink = drnk_loot.instance()
	tmp_drink.set_array_buff(Pool_Item.Drinks[drinks_count])
	add_child(tmp_drink)
	tmp_drink.global_translate(drop_location + drop_offset)

	drinks_count += 1
	if(drinks_count >= Pool_Item.Drinks.size()):
		drinks_count = 0

func set_weapon_drop():
	var tmp_weap = equip_loot.instance()
	tmp_weap.set_array_buff(Pool_Item.Weapons[weapon_count])
	add_child(tmp_weap)
	tmp_weap.global_translate(drop_location + drop_offset)

	weapon_count += 1
	if(weapon_count >= Pool_Item.Weapons.size()):
		weapon_count = 0
	
func set_armor_drop():
	var tmp_amr = equip_loot.instance()
	tmp_amr.set_array_buff(Pool_Item.Armors[armor_count])
	add_child(tmp_amr)
	tmp_amr.global_translate(drop_location + drop_offset)

	armor_count += 1
	if(armor_count >= Pool_Item.Armors.size()):
		armor_count = 0

func set_drops(gpos):
	drop_location = gpos
	drop_location.y = 0.0
	drop_offset.x = rand_range(-1, 1.8)
	drop_offset.z = rand_range(-1.5, 1)

	var tmp_value = int(rand_range(1, 21))

	var tmp_gold = gold_loot.instance()
	tmp_gold.value = int(rand_range(gold_min_aquired, gold_max_aquired))
	add_child(tmp_gold)
	tmp_gold.global_translate(drop_location - drop_offset)
	

	match tmp_value:
		1,2,3,4,5:
			set_food_drop()
		6,7,8,9,10:
			set_medicine_drop()
		11,12,13,14:
			set_drinks_drop()
		15,16,17,18:
			set_etc_drop()
		19:
			set_weapon_drop()
		20,21:
			set_armor_drop()
		_:
			pass
