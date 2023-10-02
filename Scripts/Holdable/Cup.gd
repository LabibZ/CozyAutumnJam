class_name Cup extends Holdable

var filled: bool = false
var emptyCup = Rect2(68, 102, 10, 9)
var fillCup = Rect2(84, 102, 10, 9)

func _ready():
	super()
	fill()

func fill():
	filled = true
	get_node(".").region_rect = fillCup
	order._base = "Tea"

func empty():
	filled = false
	get_node(".").region_rect = emptyCup

func add(ingredient):
	order._ingredients.append(ingredient)
	
#func getIngredients():
#	return contents
