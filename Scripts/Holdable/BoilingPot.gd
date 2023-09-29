class_name BoilingPot extends Holdable

@onready var testTimer = $Time
var current_state: BoilingState = BoilingState.EMPTY

enum BoilingState {
	EMPTY,
	FILLED,
	BOILED
}

func _process(_delta):
	testTimer.text = "%0.2f" % timer.time_left
	# TODO: REPLACE WITH SIGNALS
	if current_state == BoilingState.EMPTY:
		processing_time = 2.0
	else:
		processing_time = 5.0
