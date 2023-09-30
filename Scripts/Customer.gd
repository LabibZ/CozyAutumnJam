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

var orderId: int
var currState = CustomerState.NOT_ORDERED
var orderManager: OrderManager
var CoffeeTexture = load("res://Components/Holdable/Coffee.png")
var TeaTexture = load("res://Components/Holdable/Cup.tres")
var MilkTexture = load("res://Components/Holdable/Milk.png")
var SugarTexture = load("res://Components/Holdable/Sugar.png")

func _ready():
	orderManager = get_parent().get_node("OrderManager")

func _process(_delta):
	pass
	#if currState = ARRIVING, locate empty spot and move towards it
	#once arrived, state = NOT_ORDERED
	#once character takes their order, state = ORDER_TAKEN
	#only if order is fulfilled, state = LEAVING, customer walks out and is destroyed

func interact():
	match (currState):
		CustomerState.NOT_ORDERED:
			orderId = orderManager.generateOrder()
			displayOrder(orderManager.getOrder(orderId))
		CustomerState.ORDER_TAKEN:
			print(orderManager.getOrder(orderId))
			

func displayOrder(order: Order):
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
