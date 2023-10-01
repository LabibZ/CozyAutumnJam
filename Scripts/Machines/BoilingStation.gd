class_name BoilingStation extends Machine

func check_requirements() -> bool:
	if item is BoilingPot:
		item = item as BoilingPot
		if item.current_state == BoilingPot.BoilingState.FILLED:
			return true
	return false

func start_processing() -> void:
	super()
	item.emit_signal("boiling_state_changed")
	
func processing_done():
	super()
	item.current_state = BoilingPot.BoilingState.BOILED
	item.emit_signal("boiling_state_changed")
	print("pot boiled")

func reset_machine() -> void:
	super()
	item.emit_signal("boiling_state_changed")
