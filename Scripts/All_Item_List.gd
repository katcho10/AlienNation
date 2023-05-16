extends Node

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

#	CONSUMABLE = 1
export(Array) var Medicines = [
["Health Pill", 1, 1, 1, 125, Vector3(105.0, 5.0, 0.0), "A pill restore little of a health. Can usually buy in drug store"],
["Combine Pill", 2, 1, 1, 150, Vector3(55.0, 55.0, 0.0), "Brings back some magical beliveness points"],
["Energy Pill", 3, 1, 1, 130, Vector3(5.0, 105.0, 0.0), "Energy pill that restore little energy points"]
]
#	CONSUMABLE = 1
export(Array) var Foods = [
["Bread", 4, 1, 2, 10, Vector3(20.0, 5.0, 0.0), "Give`s some goodness. Made of flour, butter, and sugar Taste good when fresh bake"],
["Snack Bar", 5, 1, 1, 35, Vector3(5.0, 35.0, 0.0), "Other name 'Protein Bar' Milk Chocolate or Mocha flavor"],
["Cup Cake", 6, 1, 1, 20, Vector3(20.0, 20.0, 0.0), "Cake mold in a cuplike shape, comes in assorted flavor"],
["Pizza", 7, 1, 1, 40, Vector3(35.0, 35.0, 0.0), "A slice of a whole round bread toped with chesse, tomato sause and ham"],
["Hotdog", 8, 1, 1, 45, Vector3(50.0, 50.0, 0.0), "Fast food menu best sell in kids and adults too."]
]
#	CONSUMABLE = 1
export(Array) var Drinks = [
["Orange Juice", 9, 1, 1, 35, Vector3(5.0, 60.0, 0.0), "Orange flavor water sweet, stored in a tetra pack for longlast"],
["Apple Juice", 10, 1, 1, 35, Vector3(55.0, 5.0, 0.0), "Apple flavor water sweet, stored in a tetra pack for longlast"],
["Clear Soda", 11, 1, 1, 45, Vector3(35.0, 35.0, 0.0), "A carbonated water best serve chill"],
["Strawberry Soda", 12, 1, 1, 45, Vector3(5.0, 65, 0.0), "A carbonated Strawvberry flavor water best serve chill"],
["Orange Soda", 13, 1, 1, 45, Vector3(65.0, 5.0, 0.0), "A Orange flavor carbonated water best serve chill"]
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

#NON Stackable =======================================================================================================

#	WEAPON_PRI = 2
#	WEAPON_SEC = 3
export(Array) var Weapons = [
["Kitchen Knife", 20, 2, 0, 100, Vector3(10.0, 0.0, 3.0), "Kitchen utensil cut fresh meat, fish and vegetables"],
["Six Shooter", 21, 3, 0, 350, Vector3(10.0, 10.0, 0.0), "Revolver gun that shoot six energy bullets"],
["Combat Knife", 22, 2, 0, 1500, Vector3(30.0, 0.0, 10.0), "Army standard issue combat knife"],
["Hand Gun", 23, 3, 0, 2000, Vector3(20.0, 20.0, 0.0), "Low caliver gun that shoot energy bullets"],
["Katana", 24, 2, 0, 5500, Vector3(50.0, 0.0, 15.0), "A Japanesse sword good for slicing enemy"],
["Power Gun", 25, 3, 0, 5000, Vector3(30.0, 30.0, 0.0), "Energy emitting gun"],
["Alien Gun", 26, 3, 0, 8000, Vector3(5.0, 50.0, 5.0), "A gun that is look-like a toy emits energy"]
]

#	HEADGEAR = 4
var Headgear = [
["Bonnet", 27, 4, 0, 1000, Vector3(3.0, 0.0, 12.0), "headgear use in cold winter"],
["Baseball Cap", 28, 4, 0, 1500, Vector3(5.0, 0.0, 15.0), "A cap use by baseball player in game"],
["Headset", 29, 4, 0, 1525, Vector3(0.0, 12.0, 10.0), "A device use to listen music"]
]

#	TORSO_AMR = 5
#	LEGS_AMR = 6
var Armors = [
["Jacket", 30, 5, 0, 200, Vector3(2.0, 0.0, 8.0), "Protection in cold winter night"],
["Cargo Shorts", 31, 6, 0, 100, Vector3(0.0, 0.0, 8.0), "Shorts has many useful pockets"],
["Uniform Blouse", 32, 5, 0, 500, Vector3(2.0, 10.0, 6.0), "Girls upper garment use in school"],
["Uniform Skirt", 33, 6, 0, 600, Vector3(0.0, 10.0, 6.0), "Girls lower garment use in school"],
["Hockey Vest", 34, 5, 0, 1200, Vector3(5.0, 0.0, 15.0), "Vest use by hockey player made in plastic"],
["Jean Pants", 35, 6, 0, 1025, Vector3(0.0, 0.0, 15.0), "All around jean pants heavy duty"],
["Combat Jacket", 36, 5, 0, 3200, Vector3(10.0, 8.0, 20.0), "A green camouflages jacket"],
["Combat Pants", 37, 6, 0, 3000, Vector3(0.0, 8.0, 20.0), "A green camouflages pants"],
["LB Jacket", 38, 5, 0, 8800, Vector3(12.0, 10.0, 32.0), "Light weight but strong type of jacket"],
["LB Pants", 39, 6, 0, 7800, Vector3(0.0, 10.0, 30.0), "A pants made in Light Strong materials"]
]

#	BOOTS = 7
var Boots = [
["Rubber Shoes", 40, 7, 0, 192, Vector3(0.0, 0.0, 5.0), "Comportable footware light best in sports"],
["Boots", 41, 7, 0, 800, Vector3(0.0, 0.0, 10.0), "Heavy duty best for working or hikking"],
["Combat Boots", 42, 7, 0, 2300, Vector3(0.0, 0.0, 15.0), "Heavy durable footware"],
["LB Boots", 43, 7, 0, 6200, Vector3(0.0, 0.0, 25.0), "Strong boots has a hard defences"]
]

#	ACCESSORY = 8
var Accessory = [
["Beads", 44, 8, 0, 1500, Vector3(2.0, 10.0, 5.0), "A necklace made in wooden beads."],
["Dog tags", 45, 8, 0, 1350, Vector3(2.0, 0.0, 10.0), "Tag use to identify fallen soldier."],
["Silver Ring", 46, 8, 0, 3000, Vector3(10.0, 0.0, 10.0), "A polish ring made of silver."],
["Silver Chain", 47, 8, 0, 3100, Vector3(0.0, 10.0, 10.0), "Chain like neckware made of silver."],
["Jade Ring", 48, 8, 0, 3200, Vector3(0.0, 25.0, 0.0), "A ring has a jade stone attach on."],
["Ruby Ring", 49, 8, 0, 3100, Vector3(25.0, 0.0, 0.0), "Red stone attach on a ring"],
["Gold Ring", 50, 8, 0, 5100, Vector3(20.0, 0.0, 15.0), "A ring made of pure gold."],
["Gold Chain", 51, 8, 0, 5000, Vector3(0.0, 20.0, 15.0), "Necklace made of gold."]
]

# ends in id 51
