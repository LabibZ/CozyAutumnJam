class_name TeaCup extends Cup

var emptyCup = Rect2(68, 102, 10, 9)
var fillCup = Rect2(84, 102, 10, 9)

func fill():
	super()
	get_node(".").region_rect = fillCup
	order._base = "Tea"

func empty():
	super()
	dump()
	get_node(".").region_rect = emptyCup
