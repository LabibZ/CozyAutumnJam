class_name Chair extends Node2D

var isOccupied: bool = false
var occupant: Customer = null
var drink: Cup = null

func getIsOccupied():
	return isOccupied
	
func getOccupant():
	return occupant
	
func seat(customer):
	occupant = customer
	isOccupied = true
	
func unseat():
	occupant = null
	isOccupied = false
