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
@onready var audioPlayer = $AudioStreamPlayer

var current_state: TableState = TableState.ORDERS_NOT_TAKEN # TODO: CHANGE LATER
var isFull: bool = false
var tableTimer: Timer

var writingSounds = [load("res://Assets/Sounds/Effects/Writing1.wav"), load("res://Assets/Sounds/Effects/Writing2.wav")]

func interact(item = null):
	match current_state:
		TableState.EMPTY_TABLE:
			pass
		TableState.ORDERS_NOT_TAKEN:
			for chair in chairs:
				if chair.isOccupied:
					chair.getOccupant().displayOrder()
			audioPlayer.stream = writingSounds[randi()%writingSounds.size()]
			audioPlayer.play()
			current_state = TableState.ORDERS_TAKEN
		TableState.ORDERS_TAKEN:
			if (item):
				if (checkOrders(item)):
					return true

func checkOrders(item):
	for i in range(chairs.size()):
		if chairs[i].isOccupied:
			if OrderManager.checkSameOrder(chairs[i].getOrder(), item.asOrder()) and !chairs[i].checkOccupantCompleted():
				dropPoint = drops[i].global_position
				chairs[i].setOccupantCompleted()
				return true

func seatCustomers(customers: Array[Customer]):
	for i in range(customers.size()):
		if !chairs[i].getIsOccupied():
			chairs[i].seat(customers[i])
			customers[i].destination = chairs[i].global_position

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
