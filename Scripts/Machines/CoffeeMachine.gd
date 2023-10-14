class_name CoffeeMachine extends Machine

@onready var sound = $AudioStreamPlayer

func check_requirements() -> bool:
	if item is CoffeeCup:
		item = item as CoffeeCup
		if !item.filled:
			return true
	return false
	
func start_processing() -> void:
	super()
	sound.play()

func processing_done():
	super()
	item.fill()
	sound.stop()

func reset_machine() -> void:
	super()
