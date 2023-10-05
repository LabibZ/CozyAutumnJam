class_name BoilingPot extends Holdable

@onready var testTimer = $Time
@onready var timerBar: ProgressBar = $TimerBar
@onready var audioPlayer = $AudioStreamPlayer

var fillSound = load("res://Assets/Sounds/Effects/Pouring Water.wav")
var emptySound = load("res://Assets/Sounds/Effects/Pouring Tea.wav")
var boilSound = load("res://Assets/Sounds/Effects/Boiling.wav")

signal boiling_state_changed

var current_state: BoilingState = BoilingState.EMPTY

enum BoilingState {
	EMPTY,
	FILLING,
	FILLED,
	BOILING,
	BOILED,
	EMPTYING
}

func _ready():
	super()
	_on_boiling_state_changed()

func _process(_delta):
	#await _on_boiling_state_changed()
	timerBar.value = timer.time_left

func _on_boiling_state_changed():
	match current_state:
		BoilingState.EMPTY:
			processing_time = 2.0
		BoilingState.FILLING:
			audioPlayer.stream = fillSound
			audioPlayer.play()
		BoilingState.FILLED:
			audioPlayer.stop()
			processing_time = 2.0
			print("Boiled")
		BoilingState.BOILING:
			audioPlayer.stream = boilSound
			audioPlayer.play()
		BoilingState.BOILED:
			audioPlayer.stop()
			processing_time = 0.0
		BoilingState.EMPTYING:
			audioPlayer.stream = emptySound
			audioPlayer.play()
	timerBar.set_max(processing_time)
