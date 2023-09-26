extends Interactable

class_name Machine

enum MachineState {
	IDLE,
	WORKING,
	DONE
}

var current_state: MachineState = MachineState.IDLE
var processing_time: float = 5.0
var timer: Timer
@onready var testTimer = $Time
# Signals
signal machine_done

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(processing_done)

func _process(delta):
	testTimer.text = "%0.2f" % timer.time_left

func interact():
	if current_state == MachineState.IDLE:
		start_processing()
	elif current_state == MachineState.DONE:
		reset_machine()

func start_processing() -> void:
	current_state = MachineState.WORKING
	timer.start(processing_time)
	print("working")

func processing_done() -> void:
	current_state = MachineState.DONE
	# emit_signal("machine_done")
	timer.stop()
	print("done")
	
func reset_machine() -> void:
	current_state = MachineState.IDLE
	print("idle")


