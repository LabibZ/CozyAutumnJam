class_name BoilingStation extends Machine

#const MAX_CHARGE = 2
#var charges: int = 0

func interact():
	if !check_requirements():
		return
		
	if current_state == MachineState.IDLE:
		start_processing()
	elif current_state == MachineState.DONE:
		reset_machine()

func check_requirements() -> bool:
	if item is BoilingPot:
		if !item.boiled:
			return true
	return false

func start_processing():
	super()
	# check requirement of pot being filled with water
	# pot boiling
	
func processing_done():
	super()
#	charges = 2
#	print(charges)
	item.boiled = true
	print("pot boiled")

func reset_machine():
	super()
	# empty pot
