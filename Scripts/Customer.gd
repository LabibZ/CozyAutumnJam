class_name Customer extends Interactable

@onready var baseTexture = $Control/HBoxContainer/Base
@onready var VBox1 = $Control/HBoxContainer/HBoxContainer/VBoxContainer
@onready var VBox2 = $Control/HBoxContainer/HBoxContainer/VBoxContainer2
@onready var item1_1 = $Control/HBoxContainer/HBoxContainer/VBoxContainer/item1_1
@onready var item1_2 = $Control/HBoxContainer/HBoxContainer/VBoxContainer/item1_2
@onready var item2_1 = $Control/HBoxContainer/HBoxContainer/VBoxContainer2/item2_1
@onready var item2_2 = $Control/HBoxContainer/HBoxContainer/VBoxContainer2/item2_2

enum CustomerState {
	ARRIVING, 
	NOT_ORDERED, 
	ORDER_TAKEN, 
	LEAVING
}

const SPEED = 80

var destination: Vector2
var order: Order
var currState = CustomerState.ARRIVING
var CoffeeTexture = load("res://Components/Holdable/Coffee.png")
var TeaTexture = load("res://Components/Holdable/Cup.tres")
var MilkTexture = load("res://Components/Holdable/Milk.png")
var SugarTexture = load("res://Components/Holdable/Sugar.png")

func _process(_delta):
	match (currState):
		CustomerState.ARRIVING:
			if (destination):
				if (get_position() == destination):
					currState = CustomerState.NOT_ORDERED
				else:
					position = position.move_toward(destination, _delta * SPEED)
			else:
				for node in get_parent().get_node("Tables").get_children():
					var chairPos = node.seatCustomer(self)
					if (chairPos != null):
						destination = chairPos
						break
	#once character takes their order, state = ORDER_TAKEN
	#keep checking if customer is satisfied
	#only if order is fulfilled, state = LEAVING, customer walks out and is destroyed

func displayOrder():
	order = OrderManager.generateOrder()
	baseTexture.visible = true
	baseTexture.texture = getBaseTexture(order._base)
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
	currState = CustomerState.ORDER_TAKEN

func getOrder():
	return order

func getBaseTexture(base: String):
	assert(base != null)
	if base == "Tea":
		return TeaTexture
	if base == "Coffee":
		return CoffeeTexture

func getIngredientTexture(ingredient: String):
	assert(ingredient != null)
	if ingredient == "Sugar":
		return SugarTexture
	if ingredient == "Milk":
		return MilkTexture
