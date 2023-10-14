class_name BoilingStation extends Machine

func check_requirements() -> bool:
	if item is BoilingPot:
		item = item as BoilingPot
		if item.current_state == BoilingPot.BoilingState.FILLED:
			return true
	return false

func start_processing() -> void:
	super()
	item.changeState(BoilingPot.BoilingState.BOILING)
	
func processing_done():
	super()
	item.changeState(BoilingPot.BoilingState.BOILED)

func reset_machine() -> void:
	super()
