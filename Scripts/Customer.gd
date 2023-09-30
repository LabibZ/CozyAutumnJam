class_name Customer extends Interactable

enum CustomerState {ARRIVING, NOT_ORDERED, ORDER_TAKEN, LEAVING}

var orderId: int
var currState = CustomerState.NOT_ORDERED

func _process(_delta):
	pass
	#if currState = ARRIVING, locate empty spot and move towards it
	#once arrived, state = NOT_ORDERED
	#once character takes their order, state = ORDER_TAKEN
	#only if order is fulfilled, state = LEAVING, customer walks out and is destroyed

func interact():
	var orderManager = get_parent().get_node("OrderManager")
	
	match (currState):
		CustomerState.NOT_ORDERED:
			orderId = orderManager.generateOrder()
			currState = CustomerState.ORDER_TAKEN
		CustomerState.ORDER_TAKEN:
			print(orderManager.getOrder(orderId))
