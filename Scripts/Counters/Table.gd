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

var current_state: TableState = TableState.ORDERS_NOT_TAKEN # TODO: CHANGE LATER
var isFull: bool = false
var tableTimer: Timer

func interact():
	match current_state:
		TableState.ORDERS_NOT_TAKEN:
			for chair in chairs:
				if chair.isOccupied:
					chair.getOccupant().displayOrder()
			current_state = TableState.ORDERS_TAKEN
		TableState.ORDERS_TAKEN:
			# find matching order and submit
			checkOrders()

func checkOrders():
	for i in range(chairs.size()):
		if chairs[i].isOccupied:
			# TODO: error check no item
			if OrderManager.checkSameOrder(chairs[i].getOrder(), item.asOrder()) and !chairs[i].checkOccupantCompleted():
				dropPoint = drops[i].global_position
				chairs[i].setOccupantCompleted()
				break

func seatCustomer(customer):
	if !isFull:
		for chair in chairs:
			if !chair.getIsOccupied():
				chair.seat(customer)
				return chair.get_global_position()
		setFull()

func removeCustomer(customer):
	for chair in chairs:
		if chair.getOccupant() == customer:
			chair.unseat()
			isFull = false
			break

func setFull():
	isFull = true

func setEmpty():
	isFull = false
