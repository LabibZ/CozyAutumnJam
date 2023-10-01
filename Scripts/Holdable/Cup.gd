class_name Cup extends Holdable

var filled: bool = false
var contents = [];
var emptyCup = Rect2(68, 102, 10, 9)
var fillCup = Rect2(84, 102, 10, 9)

func fill():
	filled = true
	get_node(".").region_rect = fillCup
	print("cup filled")

func empty():
	get_node(".").region_rect = emptyCup
	filled = false

func add(ingredient):
	contents.append(ingredient)
	
func getIngredients():
	return contents
