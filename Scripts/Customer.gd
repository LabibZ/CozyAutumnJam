class_name Customer extends CharacterBody2D

### UI
@onready var baseTexture = $Control/HBoxContainer/Base
@onready var VBox1 = $Control/HBoxContainer/HBoxContainer/VBoxContainer
@onready var VBox2 = $Control/HBoxContainer/HBoxContainer/VBoxContainer2
@onready var item1_1 = $Control/HBoxContainer/HBoxContainer/VBoxContainer/item1_1
@onready var item1_2 = $Control/HBoxContainer/HBoxContainer/VBoxContainer/item1_2
@onready var item2_1 = $Control/HBoxContainer/HBoxContainer/VBoxContainer2/item2_1
@onready var item2_2 = $Control/HBoxContainer/HBoxContainer/VBoxContainer2/item2_2
@onready var ui = $UI
@onready var uiPlayer = $UI/AnimationPlayer
### Sprites
@onready var BodySprite = $Sprites/Body
@onready var OutfitSprite = $Sprites/Outfit
@onready var HairSprite = $Sprites/Hair
@onready var EyesSprite = $Sprites/Eyes
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")
### Managers
@onready var customerManager: CustomerManager = get_tree().current_scene.get_node("CustomerManager")

enum CustomerState {
	PATH_FOLLOW,
	ARRIVING, 
	NOT_ORDERED, 
	ORDER_TAKEN,
	ORDER_COMPLETE,
	LEAVING,
	PATH_FOLLOW_LEAVE
}

var SPEED = randi_range(40, 60)
signal customer_arrived

var destination: Vector2
var order: Order = null
var table: Table = null
var leftSeat = true
var currState = CustomerState.PATH_FOLLOW
var closestPath: PathFollow2D = null
var CoffeeTexture = load("res://Components/Holdable/Cup/CoffeeCup.png")
var TeaTexture = load("res://Components/Holdable/Cup/TeaCup.tres")
var MilkTexture = load("res://Components/Holdable/Milk.png")
var SugarTexture = load("res://Components/Holdable/Sugar.png")

func _ready():
	SpriteGenerator.GenerateCharacter(BodySprite, OutfitSprite, HairSprite, EyesSprite)

func _process(delta):
	var direction = Vector2.ZERO
	match currState:
		CustomerState.PATH_FOLLOW:
			if closestPath:
				if closestPath.progress_ratio == 1.0:
					currState = CustomerState.ARRIVING
				else:
					var old_pos = global_position
					closestPath.progress += delta * SPEED
					direction = (global_position - old_pos) * 50
		CustomerState.ARRIVING:
			if destination:
				if get_global_position() == destination:
					currState = CustomerState.NOT_ORDERED
					customer_arrived.emit()
				else:
					direction = destination - global_position
					global_position = global_position.move_toward(destination, delta * SPEED)
		CustomerState.LEAVING:
			if destination:
				if get_global_position() == destination:
					currState = CustomerState.PATH_FOLLOW_LEAVE
				else:
					direction = destination - global_position
					global_position = global_position.move_toward(destination, delta * SPEED)
		CustomerState.PATH_FOLLOW_LEAVE:
			if closestPath:
				if closestPath.progress_ratio == 0.0:
					closestPath.queue_free()
					queue_free()
				else:
					var old_pos = global_position
					closestPath.progress -= delta * SPEED
					direction = (global_position - old_pos) * 50				
	direction.normalized()
	if direction != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", direction)
		animationTree.set("parameters/Run/blend_position", direction)
		animationState.travel("Run")
	elif currState != CustomerState.PATH_FOLLOW and currState != CustomerState.ARRIVING and currState != CustomerState.LEAVING:
		if leftSeat:
			animationState.travel("sit_right")
		else:
			animationState.travel("sit_left")
	else:
		animationState.travel("Idle")
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
