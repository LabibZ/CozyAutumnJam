class_name CustomerManager extends Node2D

@onready var audioPlayer = $AudioStreamPlayer

const SPAWN_INTERVAL: float = 2.0
const MAX_CUSTOMERS = 5

var spawnTimer: Timer
var customerSize: int = 0
var waitingCustomers = []
var paths = []
var customerPrefab  = preload("res://Components/Customer.tscn")
var spawnLowerBound: float = 1.0
var spawnUpperBound: float = 2.0

var arriveSound = load("res://Assets/Sounds/Effects/Store Bell.ogg")

func _ready():
	spawnTimer = Timer.new()
	add_child(spawnTimer)
	spawnTimer.timeout.connect(trySpawnCustomers)
	for path in $Paths.get_children():
		paths.append(path as Path2D) 

func _process(_delta):
	if waitingCustomers:
		for group in waitingCustomers:
			if findEmptyTable(group):
				waitingCustomers.erase(group)

func trySpawnCustomers():
	var arrivingCustomers: Array[Customer] = []
	if (customerSize < MAX_CUSTOMERS):
		audioPlayer.stream = arriveSound
		audioPlayer.play()
		for i in range(randi_range(spawnLowerBound, spawnUpperBound)):
			if customerSize == MAX_CUSTOMERS:
				break
			spawnCustomer(arrivingCustomers)
			customerSize += 1
		waitingCustomers.append(arrivingCustomers)
	spawnTimer.start(SPAWN_INTERVAL)

func spawnCustomer(arrivingCustomers):
	var customer = customerPrefab.instantiate()
	add_child(customer)
	customer.global_position = self.global_position
	arrivingCustomers.append(customer)

func findEmptyTable(arrivingCustomers):
	for table in get_tree().current_scene.get_node("Tables").get_children():
		table = table as Table
		if !table.isFull and arrivingCustomers.size() <= table.chairs.size():
			table.seatCustomers(arrivingCustomers)
			table.setFull()
			return true
	return false

func _on_world_game_state_changed(new_state):
	match new_state:
		GameManager.GameState.RUNNING:
			spawnTimer.start(SPAWN_INTERVAL)
		GameManager.GameState.GAME_OVER:
			spawnTimer.stop()
