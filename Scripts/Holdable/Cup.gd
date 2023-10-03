class_name Cup extends Holdable

var filled: bool = false
var MilkTexture = load("res://Components/Holdable/Milk.png")
var SugarTexture = load("res://Components/Holdable/Sugar.png")

@onready var VBox1 = $Control/HBoxContainer/HBoxContainer/VBoxContainer
@onready var VBox2 = $Control/HBoxContainer/HBoxContainer/VBoxContainer2
@onready var item1_1 = $Control/HBoxContainer/HBoxContainer/VBoxContainer/item1_1
@onready var item1_2 = $Control/HBoxContainer/HBoxContainer/VBoxContainer/item1_2
@onready var item2_1 = $Control/HBoxContainer/HBoxContainer/VBoxContainer2/item2_1
@onready var item2_2 = $Control/HBoxContainer/HBoxContainer/VBoxContainer2/item2_2

func fill():
	filled = true
	order._base = "Tea"

func empty():
	filled = false
	
func add(ingredient):
	order._ingredients.append(ingredient)
	
	for i in range(order._ingredients.size()):
		match i:
			0:
				VBox1.visible = true
				item1_1.texture = getIngredientTexture(order._ingredients[i])
			1:
				item1_2.texture = getIngredientTexture(order._ingredients[i])
			2:
				VBox2.visible = true
				item2_1.texture = getIngredientTexture(order._ingredients[i])
			3:
				item2_2.texture = getIngredientTexture(order._ingredients[i])
	print("Added " + ingredient)
	
func getIngredientTexture(ingredient: String):
	assert(ingredient != null)
	if ingredient == "Sugar":
		return SugarTexture
	if ingredient == "Milk":
		return MilkTexture

	
#func getIngredients():
#	return contents
