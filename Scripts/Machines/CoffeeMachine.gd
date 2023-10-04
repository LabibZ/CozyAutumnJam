class_name CoffeeMachine extends Machine

func check_requirements() -> bool:
	if item is CoffeeCup:
		item = item as CoffeeCup
		if !item.filled:
			return true
	return false

func processing_done():
	super()
	item.fill()

func reset_machine() -> void:
	super()
