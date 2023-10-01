class_name Table extends Counter

# Placeable Drop Points
@onready var leftDrop = $LeftDrop
@onready var rightDrop = $RightDrop
@onready var botDrop = $BotDrop
@onready var topDrop = $TopDrop

@onready var chairs = [$ChairLeft, $ChairRight, $ChairBot, $ChairTop]

var isFull: bool = false

func seatCustomer(customer):
	if (!isFull):
		for chair in chairs:
			if (!chair.getIsOccupied()):
				chair.seat(customer)
				return chair.get_global_position()
	isFull = true

func removeCustomer(customer):
	for chair in chairs:
		if (chair.getOccupant() == customer):
			chair.unseat()
			isFull = false
			break
