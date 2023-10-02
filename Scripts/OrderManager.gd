extends Node2D

const BASE = ["Tea", "Coffee"]
const INGREDIENTS = ["Sugar", "Milk"]
const MAX_SUGAR = 0
const MAX_MILK = 0

func generateOrder():
	var base = randi()%BASE.size()
	var numSugar = randi()%(MAX_SUGAR + 1)
	var numMilk = randi()%(MAX_MILK + 1)
	
	var ingredients = []
	for i in range(numSugar):
		ingredients.append("Sugar")
	for i in range(numMilk):
		ingredients.append("Milk")
	# orders.append(Order.new(BASE[base], ingredients))
	print(BASE[base])
	print(ingredients)
	
	#return the index of the order for reference in customer object
	return Order.new(BASE[base], ingredients)

func checkSameOrder(order1: Order, order2: Order) -> bool:
	if order1._base != order2._base:
		return false
	if (!hasSameContents(order1._ingredients, order2._ingredients)):
		return false
	return true
	
func hasSameContents(a1, a2) -> bool:
	if a1.size() != a2.size(): 
		return false
	for item in a1:
		if !a2.has(item): 
			return false
		if a1.count(item) != a2.count(item): 
			return false
	return true
