class_name Cup extends Holdable

var filled: bool = false

func fill():
	filled = true
	order._base = "Tea"

func empty():
	filled = false

func add(ingredient):
	order._ingredients.append(ingredient)
	
#func getIngredients():
#	return contents
