class_name CustomerManager extends Node2D

const SPAWN_INTERVAL: float = 2.0
const MAX_CUSTOMERS = 5

var spawnTimer: Timer
var customers: Array[Customer] = []
var arrivingCustomers: Array[Customer] = []
var customerPrefab  = preload("res://Components/Customer.tscn")
var spawnLowerBound: float
var spawnUpperBound: float

func _ready():
	spawnTimer = Timer.new()
	add_child(spawnTimer)
	spawnTimer.timeout.connect(trySpawnCustomers)

func _process(_delta):
	for customer in arrivingCustomers:
		if customer.destination:
			if customer.get_position() == customer.destination:
				customer.currState = Customer.CustomerState.NOT_ORDERED
				arrivingCustomers = []
			else:
				customer.position = customer.position.move_toward(customer.destination, _delta * customer.SPEED)

func trySpawnCustomers():
	if (customers.size() < MAX_CUSTOMERS):
		for i in range(randi_range(spawnLowerBound, spawnUpperBound)):
			if customers.size() == MAX_CUSTOMERS:
				break
			spawnCustomer()
		findEmptyTable()
		addToCustomers()
	spawnTimer.start(SPAWN_INTERVAL)

func spawnCustomer():
	var customer = customerPrefab.instantiate()
	get_tree().current_scene.add_child(customer)
	customer.global_position = self.global_position
	arrivingCustomers.append(customer)

func findEmptyTable():
	for table in get_tree().current_scene.get_node("Tables").get_children():
		table = table as Table
		if !table.isFull:
			table.seatCustomers(arrivingCustomers)
			table.setFull()
			table.current_state = Table.TableState.ORDERS_NOT_TAKEN
			break

func addToCustomers():
	for customer in arrivingCustomers:
		customers.append(customer)

func _on_world_game_state_changed(new_state):
	match new_state:
		GameManager.GameState.RUNNING:
			spawnTimer.start(SPAWN_INTERVAL)
			spawnLowerBound = 1.0
			spawnUpperBound = 2.0
