class_name Order extends Node2D

var _base = ""
var _ingredients = []

func _init(base, ingredients):
	_base = base
	_ingredients = ingredients

func _to_string():
	var order = "Base: " + _base + "\nIngredients: "
	for i in _ingredients:
		order += i + ", "
	return order
