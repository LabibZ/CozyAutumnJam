class_name Customer extends Interactable

@onready var baseTexture = $Control/HBoxContainer/Base
@onready var VBox1 = $Control/HBoxContainer/HBoxContainer/VBoxContainer
@onready var VBox2 = $Control/HBoxContainer/HBoxContainer/VBoxContainer2
@onready var item1_1 = $Control/HBoxContainer/HBoxContainer/VBoxContainer/item1_1
@onready var item1_2 = $Control/HBoxContainer/HBoxContainer/VBoxContainer/item1_2
@onready var item2_1 = $Control/HBoxContainer/HBoxContainer/VBoxContainer2/item2_1
@onready var item2_2 = $Control/HBoxContainer/HBoxContainer/VBoxContainer2/item2_2
@onready var ui = $UI
@onready var uiPlayer = $UI/AnimationPlayer
@onready var customerManager: CustomerManager = get_tree().current_scene.get_node("CustomerManager")

enum CustomerState {
	ARRIVING, 
	NOT_ORDERED, 
	ORDER_TAKEN,
	ORDER_COMPLETE,
	LEAVING
}

const SPEED = 80
signal customer_arrived

var destination: Vector2
var order: Order = null
var table: Table = null
var currState = CustomerState.ARRIVING
var CoffeeTexture = load("res://Components/Holdable/Cup/CoffeeCup.png")
var TeaTexture = load("res://Components/Holdable/Cup/TeaCup.tres")
var MilkTexture = load("res://Components/Holdable/Milk.png")
var SugarTexture = load("res://Components/Holdable/Sugar.png")

func _process(delta):
	match currState:
		CustomerState.ARRIVING:
			if destination:
				if get_position() == destination:
					currState = CustomerState.NOT_ORDERED
					customer_arrived.emit()
				else:
					position = position.move_toward(destination, delta * SPEED)
		CustomerState.LEAVING:
			position = position.move_toward(destination, delta * SPEED)
			if get_position() == destination:
				queue_free()
	#once character takes their order, state = ORDER_TAKEN
	#keep checking if customer is satisfied

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

func completeOrder():
	baseTexture.texture = null
	item1_1.texture = null
	item1_2.texture = null
	item2_1.texture = null
	item2_2.texture = null
	baseTexture.visible = false
	VBox1.visible = false
	VBox2.visible = false
	ui.visible = true
	uiPlayer.play("happy")
	currState = CustomerState.ORDER_COMPLETE

func leave():
	currState = CustomerState.LEAVING
	destination = customerManager.global_position
	customerManager.customerSize -= 1

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
