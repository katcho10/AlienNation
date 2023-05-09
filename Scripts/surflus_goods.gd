extends Resource


class_name surflus_goods

export(Array) var stocks = [
["Six Shooter", 21, 3, 0, 350, Vector3(10.0, 10.0, 0.0), "Revolver gun that shoot six magical bullets"],
["Cargo Shorts", 26, 6, 0, 100, Vector3(1.0, 0.0, 5.0), "Shorts has many useful pockets"],
["Jean Pants", 27, 6, 0, 150, Vector3(0.0, 1.0, 8.0), "All around jean pants heavy duty"],
["Rubber Shoes", 28, 7, 0, 192, Vector3(0.0, 0.0, 5.0), "Comportable footware light best in sports"],
["Boots", 29, 7, 0, 290, Vector3(0.0, 0.0, 8.0), "Heavy duty best for working or hikking"]
]

func get_stocks_count():
	return stocks.size()
