class_name Chair extends Node2D

var isOccupied: bool = false
var occupant: Customer = null
var closestPath: Path2D = null

func getIsOccupied() -> bool:
	return isOccupied
	
func getOccupant() -> Customer:
	return occupant
	
func getOrder() -> Order:
	return occupant.getOrder()

func checkOccupantCompleted() -> bool:
	return occupant.currState == Customer.CustomerState.ORDER_COMPLETE

func checkOccupantNotOrdered() -> bool:
	return occupant.currState == Customer.CustomerState.NOT_ORDERED

func setOccupantCompleted() -> void:
	occupant.completeOrder()
	
func setOccupantLeaving() -> void:
	occupant.leave()
	
func setOccupantClosestPath() -> void:
	var path_follow = PathFollow2D.new()
	path_follow.loop = false
	path_follow.rotates = false
	closestPath.add_child(path_follow)
	occupant.closestPath = path_follow
	occupant.get_parent().remove_child(occupant)
	occupant.closestPath.add_child(occupant)
	print(closestPath)

func setClosestPath(path: Path2D) -> void:
	closestPath = path

func seat(customer: Customer) -> void:
	occupant = customer
	isOccupied = true
	setOccupantClosestPath()
	
func unseat() -> void:
	occupant = null
	isOccupied = false
