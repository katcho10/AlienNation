extends Resource


class_name drug_store_goods

export(Array) var stocks = [
["Health Pill", 1, 1, 1, 125, Vector3(100.0, 10.0, 0.0), "A pill restore little of a health. Can usually buy in drug store"],
["Magic Pill", 2, 1, 1, 150, Vector3(50.0, 50.0, 0.0), "Brings back some magical beliveness points"],
["Spirit Pill", 3, 1, 1, 130, Vector3(30.0, 30.0, 0.0), "Encouragement pill that restore spirit points"]
]

func get_stocks_count():
	return stocks.size()
