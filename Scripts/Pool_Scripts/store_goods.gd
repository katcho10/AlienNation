extends Resource


class_name store_goods

export(Array) var stocks = [
["Bread", 4, 1, 2, 10, Vector3(20.0, 5.0, 0.0), "Give`s some goodness. Made of flour, butter, and sugar Taste good when fresh bake"],
["Cup Cake", 6, 1, 1, 20, Vector3(20.0, 20.0, 0.0), "Cake mold in a cuplike shape, comes in assorted flavor"],
["Orange Juice", 9, 1, 1, 35, Vector3(5.0, 60.0, 0.0), "Orange flavor water sweet, stored in a tetra pack for longlast"],
["Apple Juice", 10, 1, 1, 35, Vector3(55.0, 5.0, 0.0), "Apple flavor water sweet, stored in a tetra pack for longlast"],
["Clear Soda", 11, 1, 1, 45, Vector3(35.0, 35.0, 0.0), "A carbonated water best serve chill"]
]

func get_stocks_count():
	return stocks.size()
