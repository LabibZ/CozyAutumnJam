class_name Table extends Counter

enum TableState {
	EMPTY_TABLE,
	ORDERS_NOT_TAKEN,
	ORDERS_TAKEN,
	ORDERS_COMPLETE
}

@onready var dropPoint: Vector2 = self.global_position
@onready var audioPlayer = $AudioStreamPlayer

var drops: Array[Marker2D] = []
var chairs: Array[Chair] = []
var current_state: TableState = TableState.EMPTY_TABLE
var items: Array[Holdable] = []
var isFull: bool = false
var tableTimer: Timer
var customerManager: CustomerManager

var writingSounds = [load("res://Assets/Sounds/Effects/Writing1.wav"), load("res://Assets/Sounds/Effects/Writing2.wav")]

func _ready():
	super()
	customerManager = get_tree().current_scene.get_node("CustomerManager") as CustomerManager
	for chair in $Chairs.get_children():
		chairs.append(chair)
		setClosestPath(chair) # may cause problems if CustomerManager is not loaded first
		if self.global_position.x - chair.global_position.x < 0:
			chair.leftSeat = false
	for drop in $Drops.get_children():
		drops.append(drop)
	
func interact(held_item = null):
	match current_state:
		TableState.ORDERS_NOT_TAKEN:
			for chair in chairs:
				if chair.isOccupied:
					chair.getOccupant().displayOrder()
			audioPlayer.stream = writingSounds[randi()%writingSounds.size()]
			audioPlayer.play()
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
				if checkAllOrdersCompleted():
					current_state = TableState.ORDERS_COMPLETE
					set_item(held_item) # last element
					removeCustomers()
				return true

func checkAllOrdersNotTaken():
	for chair in chairs:
		if chair.isOccupied:
			if !chair.checkOccupantNotOrdered():
				return false
	return true

func checkAllOrdersCompleted():
	for chair in chairs:
		if chair.isOccupied:
			if !chair.checkOccupantCompleted():
				return false
	return true

func seatCustomers(customers: Array[Customer]):
	for i in range(customers.size()):
		if !chairs[i].getIsOccupied():
			chairs[i].seat(customers[i])
			customers[i].connect("customer_arrived", _on_customer_arrived)
			customers[i].destination = chairs[i].global_position

func removeCustomers():
	await get_tree().create_timer(3.0).timeout
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

func setClosestPath(chair: Chair):
	var closest = INF
	var closest_path = null
	for path in customerManager.paths:
		var path_end = path.curve.get_point_position(path.curve.point_count - 1) + path.global_position
		var distance = chair.global_position.distance_to(path_end)
		if (distance < closest):
			closest = distance
			closest_path = path
	chair.setClosestPath(closest_path)

func set_item(object):
	items.append(object)
	print(items.size())

func setFull():
	isFull = true

func setEmpty():
	isFull = false

func _on_customer_arrived():
	if checkAllOrdersNotTaken():
		current_state = TableState.ORDERS_NOT_TAKEN
