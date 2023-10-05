class_name Sink extends Machine

func _ready():
	super()
	
func start_processing() -> void:
	super()
	item.current_state = BoilingPot.BoilingState.FILLING
	item.emit_signal("boiling_state_changed")

func check_requirements() -> bool:
	if item is BoilingPot:
		item = item as BoilingPot
		if item.current_state == BoilingPot.BoilingState.EMPTY:
			return true
	return false

func processing_done():
	super()
	item.current_state = BoilingPot.BoilingState.FILLED
	item.emit_signal("boiling_state_changed")
