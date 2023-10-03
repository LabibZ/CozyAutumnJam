class_name BoilingPot extends Holdable

@onready var testTimer = $Time
@onready var timerBar: ProgressBar = $TimerBar

signal boiling_state_changed

var current_state: BoilingState = BoilingState.EMPTY

enum BoilingState {
	EMPTY,
	FILLED,
	BOILED
}

func _ready():
	super()
	_on_boiling_state_changed()

func _process(_delta):
	await _on_boiling_state_changed()
	timerBar.value = timer.time_left

func _on_boiling_state_changed():
	match current_state:
		BoilingState.EMPTY:
			processing_time = 2.0
		BoilingState.FILLED:
			processing_time = 2.0
		BoilingState.BOILED:
			processing_time = 0.0
	timerBar.set_max(processing_time)
