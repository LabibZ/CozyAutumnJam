class_name Table extends Counter

enum TableState {
	EMPTY_TABLE,
	ORDERS_NOT_TAKEN,
	ORDERS_TAKEN,
	ORDERS_COMPLETE
}

# Placeable Drop Points
@onready var leftDrop = $LeftDrop
@onready var rightDrop = $RightDrop
@onready var botDrop = $BotDrop
@onready var topDrop = $TopDrop

@onready var chairs: Array[Chair] = [$ChairLeft, $ChairRight, $ChairBot, $ChairTop]

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
			if !checkOrders():
				pass
			# display ui notif if not matching

func checkOrders():
	for chair in chairs:
		if chair.isOccupied:
			if (!OrderManager.checkSameOrder(chair.getOrder(), item.asOrder())):
				print("found matching order")
				return true
	return false

func seatCustomer(customer):
	if !isFull:
		for chair in chairs:
			if !chair.getIsOccupied():
				chair.seat(customer)
				return chair.get_global_position()
	isFull = true

func removeCustomer(customer):
	for chair in chairs:
		if chair.getOccupant() == customer:
			chair.unseat()
			isFull = false
			break
