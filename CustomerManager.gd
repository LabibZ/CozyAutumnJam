class_name CustomerManager extends Node

const SPAWN_INTERVAL: float = 5.0
const MAX_CUSTOMERS = 4

var timePassed: float = 0
var customers: Array[Customer] = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timePassed += delta
	if (timePassed >= SPAWN_INTERVAL && customers.size() < MAX_CUSTOMERS):
		#spawn customer
		timePassed = 0

func spawnCustomer():
	var customer = Customer.new()
	
