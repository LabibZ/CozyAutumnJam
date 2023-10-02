extends Cup

var emptyCup = Rect2(18, 1, 12, 14)
var fillCup = Rect2(2, 1, 12, 14)

func fill():
	super()
	get_node(".").region_rect = fillCup

func empty():
	super()
	get_node(".").region_rect = emptyCup
