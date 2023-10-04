class_name Table extends Counter

enum TableState {
	EMPTY_TABLE,
	ORDERS_NOT_TAKEN,
	ORDERS_TAKEN,
	ORDERS_COMPLETE
}

@onready var drops: Array[Marker2D] = [$LeftDrop, $RightDrop, $BotDrop, $TopDrop]
@onready var chairs: Array[Chair] = [$ChairLeft, $ChairRight, $ChairBot, $ChairTop]
@onready var dropPoint: Vector2 = self.global_position

var current_state: TableState = TableState.EMPTY_TABLE
var items: Array[Holdable] = []
var isFull: bool = false
var tableTimer: Timer

func _ready():
	super()

func interact(held_item = null):
	match current_state:
		TableState.ORDERS_NOT_TAKEN:
			for chair in chairs:
				if chair.isOccupied:
					chair.getOccupant().displayOrder()
			current_state = TableState.ORDERS_TAKEN
		TableState.ORDERS_TAKEN:
			if held_item:
				if checkOrders(held_item):
					return true

func checkOrders(held_item):
	for i in range(chairs.size()):
		if chairs[i].isOccupied:
			if OrderManager.checkSameOrder(chairs[i].getOrder(), held_item.asOrder()) and !chairs[i].checkOccupantCompleted():
				dropPoint = drops[i].global_position
				chairs[i].setOccupantCompleted()
				if checkAllOrders():
					current_state = TableState.ORDERS_COMPLETE
					set_item(held_item) # last element
					removeCustomers()
				return true

func checkAllOrders():
	for chair in chairs:
		if chair.isOccupied:
			if !chair.checkOccupantCompleted():
				return false
	return true

func seatCustomers(customers: Array[Customer]):
	for i in range(customers.size()):
		if !chairs[i].getIsOccupied():
			chairs[i].seat(customers[i])
			customers[i].destination = chairs[i].global_position

func removeCustomers():
	for chair in chairs:
		if chair.isOccupied:
			chair.setOccupantLeaving()
			chair.unseat()
	for it in items:
		if is_instance_valid(it):
			it.queue_free()
			it = null
	items.clear()
	setEmpty()

func set_item(object):
	items.append(object)
	print(items.size())

func setFull():
	isFull = true

func setEmpty():
	isFull = false
