class_name Chair extends Node2D

var isOccupied: bool = false
var occupant: Customer = null

func getIsOccupied() -> bool:
	return isOccupied
	
func getOccupant() -> Customer:
	return occupant
	
func getOrder() -> Order:
	return occupant.getOrder()

func checkOccupantCompleted() -> bool:
	return occupant.currState == Customer.CustomerState.ORDER_COMPLETE

func setOccupantCompleted() -> void:
	occupant.currState = Customer.CustomerState.ORDER_COMPLETE

func seat(customer: Customer) -> void:
	occupant = customer
	isOccupied = true
	
func unseat() -> void:
	occupant = null
	isOccupied = false