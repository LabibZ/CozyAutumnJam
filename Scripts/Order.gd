class_name Order extends Node2D

var _base = ""
var _ingredients = []
var _accepted: bool = false
var _completed: bool = false

func _init(base, ingredients):
	_base = base
	_ingredients = ingredients

func acceptOrder():
	_accepted = true

func completeOrder(base, ingredients):
	if base != _base:
		return
	if (hasSameContents(ingredients, _ingredients)):
		_completed = true
	
func hasSameContents(a1, a2):
	if a1.size() != a2.size(): 
		return false
	for item in a1:
		if !a2.has(item): 
			return false
		if a1.count(item) != a2.count(item): 
			return false
	return true

func _to_string():
	var order = "Base: " + _base + "\nIngredients: "
	for i in _ingredients:
		order += i + ", "
	return order
