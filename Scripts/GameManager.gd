class_name GameManager extends Node2D

enum GameState {
	PREPARE,
	RUNNING,
	PAUSED,
	GAME_OVER
}

var current_state: GameState = GameState.PREPARE
var levelTimer: Timer
var levelTotalTime: float = 60.0
var score: int = 0

@onready var levelTimerText = $levelTimer

signal game_state_changed(new_state)

func _ready():
	setup_level()
	set_game_state(GameState.PREPARE)
	
func _input(_event):
	if Input.is_key_pressed(KEY_K) and current_state == GameState.PREPARE:
		set_game_state(GameState.RUNNING)
		print("game running")

func _process(_delta):
	if levelTimerText:
		levelTimerText.text = "%0.2f" % levelTimer.time_left

func set_game_state(new_state):
	current_state = new_state
	emit_signal("game_state_changed", new_state)
	match current_state:
		GameState.PREPARE:
			pass
		GameState.RUNNING:
			RunGame()
		GameState.PAUSED:
			# Pause other gameplay mechanics
			pass
		GameState.GAME_OVER:
			# Display results, maybe restart option
			pass

func RunGame():
	levelTimer.start(levelTotalTime)

func PauseGame():
	pass

func setup_level():
	# init level ?
	score = 0
	# Initialize Timer
	levelTimer = Timer.new()
	add_child(levelTimer)
	levelTimer.timeout.connect(end_level)
	# Start Customers
	
func end_level():
	levelTimer.stop()
