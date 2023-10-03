class_name Ingredient extends Holdable

var ingredient = ""

func _init():
	add_to_group("Ingredient")

func getIngredient():
	return ingredient
