extends Resource


class_name surplus002_goods

export(Array) var stocks = [
["Katana", 24, 2, 0, 5500, Vector3(50.0, 0.0, 15.0), "A Japanesse sword good for slicing enemy"],
["Power Gun", 25, 3, 0, 5000, Vector3(30.0, 30.0, 0.0), "Energy emitting gun"],
["Alien Gun", 26, 3, 0, 8000, Vector3(5.0, 50.0, 5.0), "A gun that is look-like a toy emits energy"],
["Combat Jacket", 36, 5, 0, 3200, Vector3(10.0, 8.0, 20.0), "A green camouflages jacket"],
["Combat Pants", 37, 6, 0, 3000, Vector3(0.0, 8.0, 20.0), "A green camouflages pants"],
["Combat Boots", 42, 7, 0, 2300, Vector3(0.0, 0.0, 15.0), "Heavy durable footware"],
["LB Jacket", 38, 5, 0, 8800, Vector3(12.0, 10.0, 32.0), "Light weight but strong type of jacket"],
["LB Pants", 39, 6, 0, 7800, Vector3(0.0, 10.0, 30.0), "A pants made in Light Strong materials"],
["LB Boots", 43, 7, 0, 6200, Vector3(0.0, 0.0, 25.0), "Strong boots has a hard defences"],
["Gold Ring", 50, 8, 0, 5100, Vector3(20.0, 0.0, 15.0), "A ring made of pure gold."],
["Gold Chain", 51, 8, 0, 5000, Vector3(0.0, 20.0, 15.0), "Necklace made of gold."]
]


func get_stocks_count():
	return stocks.size()
