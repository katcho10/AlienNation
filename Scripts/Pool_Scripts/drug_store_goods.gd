extends Resource


class_name drug_store_goods

export(Array) var stocks = [
["Health Pill", 1, 1, 1, 125, Vector3(105.0, 5.0, 0.0), "A pill restore little of a health. Can usually buy in drug store"],
["Combine Pill", 2, 1, 1, 150, Vector3(55.0, 55.0, 0.0), "Brings back some magical beliveness points"],
["Energy Pill", 3, 1, 1, 130, Vector3(5.0, 105.0, 0.0), "Energy pill that restore little energy points"]
]

func get_stocks_count():
	return stocks.size()
