extends Resource

#enum ITEM_type {
#	NONE = 0,
#	CONSUMABLE = 1,
#	WEAPON_PRI = 2,
#	WEAPON_SEC = 3,
#	HEADGEAR = 4,
#	TORSO_AMR = 5,
#	LEGS_AMR = 6,
#	BOOTS = 7,
#	ACCESSORY = 8,
#	ETC = 9
#}

# The Order of Properties
#	[0] var iname:String = "None"
#	[1] var ID = 0 and it is equal to frame of Animated sprite
#	[2] var type = 0
#	[3] var count_or_ups = 0
#	[4] var price = 0
#	[5] var value:Vector3 = Vector3.ZERO
# 	[6] var description:String = "None"

# Weapons and Armors has a desame property gives
#	x = attack, y = magical attack, z = defense 

class_name Item_Pool

#	CONSUMABLE = 1
export(Array) var Medicines = [
["Health Pill", 1, 1, 1, 125, Vector3(100.0, 10.0, 0.0), "A pill restore little of a health. Can usually buy in drug store"],
["Magic Pill", 2, 1, 1, 150, Vector3(50.0, 50.0, 0.0), "Brings back some magical beliveness points"],
["Spirit Pill", 3, 1, 1, 130, Vector3(30.0, 30.0, 0.0), "Encouragement pill that restore spirit points"]
]
#	CONSUMABLE = 1
export(Array) var Foods = [
["Bread", 4, 1, 2, 10, Vector3(20.0, 5.0, 0.0), "Give`s some goodness. Made of flour, butter, and sugar Taste good when fresh bake"],
["Snack Bar", 5, 1, 1, 35, Vector3(20.0, 40.0, 0.0), "Other name 'Protein Bar' Milk Chocolate or Mocha flavor"],
["Cup Cake", 6, 1, 1, 20, Vector3(30.0, 10.0, 0.0), "Cake mold in a cuplike shape, comes in assorted flavor"],
["Pizza", 7, 1, 1, 40, Vector3(40.0, 40.0, 0.0), "A slice of a whole round bread toped with chesse, tomato sause and ham"],
["Hotdog", 8, 1, 1, 43, Vector3(50.0, 50.0, 0.0), "Fast food menu best sell in kids and adults too."]
]
#	CONSUMABLE = 1
export(Array) var Drinks = [
["Orange Juice", 9, 1, 1, 35, Vector3(10.0, 56.0, 0.0), "Orange flavor water sweet, stored in a tetra pack for longlast"],
["Apple Juice", 10, 1, 1, 35, Vector3(25.0, 50.0, 0.0), "Apple flavor water sweet, stored in a tetra pack for longlast"],
["Clear Soda", 11, 1, 1, 45, Vector3(45.0, 49.0, 0.0), "A carbonated water best serve chill"],
["Strawberry Soda", 12, 1, 1, 45, Vector3(10.0, 69, 0.0), "A carbonated Strawvberry flavor water best serve chill"],
["Orange Soda", 13, 1, 1, 45, Vector3(23.0, 75.0, 0.0), "A Orange flavor carbonated water best serve chill"]
]

#	ETC = 9
export(Array) var OtherItems = [
["Pencil", 14, 9, 1, 10, Vector3(0.0, 0.0, 0.0), "Wooden carbon centered tool use to write in school"],
["Note Book", 15, 9, 1, 15, Vector3(0.0, 0.0, 0.0), "Use to write down notes usually comes in a hundred leaves"],
["Unknown Book", 16, 9, 1, 32, Vector3(0.0, 0.0, 0.0), "An old mysterious dusty book"],
["Spring", 17, 9, 1, 32, Vector3(0.0, 0.0, 0.0), "Used spring from unknown thing"],
["Battery Cell", 18, 9, 1, 10, Vector3(0.0, 0.0, 0.0), "Carbon made battery use in toys and etc."],
["Battery Pack", 19, 9, 1, 50, Vector3(0.0, 0.0, 0.0), "A Battery use in small vehicle and can be recharges"]
]

#	WEAPON_PRI = 2
#	WEAPON_SEC = 3
export(Array) var Weapons = [
["Kitchen Knife", 20, 2, 0, 100, Vector3(10.0, 0.0, 2.0), "Kitchen utensil cut fresh meat, fish and vegetables"],
["Six Shooter", 21, 3, 0, 350, Vector3(10.0, 10.0, 0.0), "Revolver gun that shoot six magical bullets"],
["Hand Gun", 22, 3, 0, 500, Vector3(15.0, 15.0, 0.0), "Low caliver gun that shoot magical bullets"]
]

#	HEADGEAR = 4
#	TORSO_AMR = 5
#	LEGS_AMR = 6
#	BOOTS = 7
#	ACCESSORY = 8
export(Array) var Armors = [
["Jacket", 23, 5, 0, 200, Vector3(1.0, 0.0, 8.0), "Protection in cold winter night"],
["Hockey Vest", 24, 5, 0, 320, Vector3(0.0, 0.0, 12.0), "Vest use by hockey player made in plastic"],
["Uniform Blouse", 25, 5, 0, 175, Vector3(1.0, 5.0, 6.0), "Girls upper garment use in school"],
["Cargo Shorts", 26, 6, 0, 100, Vector3(1.0, 0.0, 5.0), "Shorts has many useful pockets"],
["Jean Pants", 27, 6, 0, 150, Vector3(0.0, 1.0, 8.0), "All around jean pants heavy duty"],
["Rubber Shoes", 28, 7, 0, 192, Vector3(0.0, 0.0, 5.0), "Comportable footware light best in sports"],
["Boots", 29, 7, 0, 290, Vector3(0.0, 0.0, 8.0), "Heavy duty best for working or hikking"]
]

func get_food_count():
	return Foods.size()
	
func get_medicine_count():
	return Medicines.size()

func get_Drink_count():
	return Drinks.size()
	
func get_OtherItem_count():
	return OtherItems.size()
	
func get_Weapon_count():
	return Weapons.size()
	
func get_Armor_count():
	return Armors.size()
