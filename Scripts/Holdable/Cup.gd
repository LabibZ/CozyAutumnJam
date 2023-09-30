class_name Cup extends Holdable

var filled: bool = false
var contents = [];

func fill():
	filled = true
	print("cup filled")

func empty():
	filled = false

func add(ingredient):
	contents.append(ingredient)
	
func getIngredients():
	return contents
