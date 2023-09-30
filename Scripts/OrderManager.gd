class_name OrderManager extends Node2D

const BASE = ["Tea", "Coffee"]
const INGREDIENTS = ["Sugar", "Milk"]
const MAX_SUGAR = 2
const MAX_MILK = 2

@export var orders: Array[Order] = []

func generateOrder():
	var base = randi()%BASE.size()
	var numSugar = randi()%(MAX_SUGAR + 1)
	var numMilk = randi()%(MAX_MILK + 1)
	
	var ingredients = []
	for i in range(numSugar):
		ingredients.append("Sugar")
	for i in range(numMilk):
		ingredients.append("Milk")
	orders.append(Order.new(BASE[base], ingredients))
	
	print(BASE[base])
	print(ingredients)
	
	#return the index of the order for reference in customer object
	return orders.size() - 1
	
func getOrder(id):
	return orders[id]
