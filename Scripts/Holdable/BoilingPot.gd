class_name BoilingPot extends Holdable

@onready var testTimer = $Time
@onready var timerBar: ProgressBar = $TimerBar
@onready var audioPlayer = $AudioStreamPlayer

signal boiling_state_changed

var current_state: BoilingState = BoilingState.EMPTY

var fillSound = load("res://Assets/Sounds/Effects/Pouring Water.wav")
var boilSound = load("res://Assets/Sounds/Effects/Boiling.wav")

enum BoilingState {
	EMPTY,
	FILLING,
	FILLED,
	BOILING,
	BOILED
}

func _ready():
	super()
	_on_boiling_state_changed()

func _process(_delta):
	timerBar.value = timer.time_left

func changeState(state):
	current_state = state
	_on_boiling_state_changed()

func _on_boiling_state_changed():
	match current_state:
		BoilingState.EMPTY:
			processing_time = 2.0
		BoilingState.FILLING:
			playSound(fillSound)
		BoilingState.FILLED:
			audioPlayer.stop()
			processing_time = 2.0
		BoilingState.BOILING:
			playSound(boilSound)
		BoilingState.BOILED:
			audioPlayer.stop()
			processing_time = 0.0
	timerBar.set_max(processing_time)

func playSound(sound):
	audioPlayer.stream = sound
	audioPlayer.play()
