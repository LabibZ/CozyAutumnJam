class_name Sink extends Machine

@onready var dropPoint = $DropPoint.global_position

func _ready():
	super()
	
func start_processing() -> void:
	super()
	item.changeState(BoilingPot.BoilingState.FILLING)

func check_requirements() -> bool:
	if item is BoilingPot:
		item = item as BoilingPot
		if item.current_state == BoilingPot.BoilingState.EMPTY:
			return true
	return false

func processing_done():
	super()
	item.changeState(BoilingPot.BoilingState.FILLED)
