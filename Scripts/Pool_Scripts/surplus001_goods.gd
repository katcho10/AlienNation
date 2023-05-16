extends Resource


class_name surplus001_goods

export(Array) var stocks = [
["Kitchen Knife", 20, 2, 0, 100, Vector3(10.0, 0.0, 3.0), "Kitchen utensil cut fresh meat, fish and vegetables"],
["Six Shooter", 21, 3, 0, 350, Vector3(10.0, 10.0, 0.0), "Revolver gun that shoot six energy bullets"],
["Combat Knife", 22, 2, 0, 1500, Vector3(30.0, 0.0, 10.0), "Army standard issue combat knife"],
["Hand Gun", 23, 3, 0, 2000, Vector3(20.0, 20.0, 0.0), "Low caliver gun that shoot energy bullets"],
["Bonnet", 27, 4, 0, 1000, Vector3(3.0, 0.0, 12.0), "headgear use in cold winter"],
["Baseball Cap", 28, 4, 0, 1500, Vector3(5.0, 0.0, 15.0), "A cap use by baseball player in game"],
["Headset", 29, 4, 0, 1525, Vector3(0.0, 12.0, 10.0), "A device use to listen music"],
["Jacket", 30, 5, 0, 200, Vector3(2.0, 0.0, 8.0), "Protection in cold winter night"],
["Cargo Shorts", 31, 6, 0, 100, Vector3(0.0, 0.0, 8.0), "Shorts has many useful pockets"],
["Uniform Blouse", 32, 5, 0, 500, Vector3(2.0, 10.0, 6.0), "Girls upper garment use in school"],
["Uniform Skirt", 33, 6, 0, 600, Vector3(0.0, 10.0, 6.0), "Girls lower garment use in school"],
["Hockey Vest", 34, 5, 0, 1200, Vector3(5.0, 0.0, 15.0), "Vest use by hockey player made in plastic"],
["Jean Pants", 35, 6, 0, 1025, Vector3(0.0, 0.0, 15.0), "All around jean pants heavy duty"],
["Rubber Shoes", 40, 7, 0, 192, Vector3(0.0, 0.0, 5.0), "Comportable footware light best in sports"],
["Boots", 41, 7, 0, 800, Vector3(0.0, 0.0, 10.0), "Heavy duty best for working or hikking"],
["Beads", 44, 8, 0, 1500, Vector3(2.0, 10.0, 5.0), "A necklace made in wooden beads."],
["Dog tags", 45, 8, 0, 1350, Vector3(2.0, 0.0, 10.0), "Tag use to identify fallen soldier."],
["Silver Ring", 46, 8, 0, 3000, Vector3(10.0, 0.0, 10.0), "A polish ring made of silver."],
["Silver Chain", 47, 8, 0, 3100, Vector3(0.0, 10.0, 10.0), "Chain like neckware made of silver."],
["Jade Ring", 48, 8, 0, 3200, Vector3(0.0, 25.0, 0.0), "A ring has a jade stone attach on."],
["Ruby Ring", 49, 8, 0, 3100, Vector3(25.0, 0.0, 0.0), "Red stone attach on a ring"]
]


func get_stocks_count():
	return stocks.size()
