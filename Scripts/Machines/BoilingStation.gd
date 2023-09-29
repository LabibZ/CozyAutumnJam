class_name BoilingStation extends Machine

func check_requirements() -> bool:
	if item is BoilingPot:
		item = item as BoilingPot
		if item.current_state == BoilingPot.BoilingState.FILLED:
			return true
	return false

func processing_done():
	super()
	item.current_state = BoilingPot.BoilingState.BOILED
	print("pot boiled")
