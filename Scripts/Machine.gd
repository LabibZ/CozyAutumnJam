extends Node2D

class_name Machine

enum MachineState {
	IDLE,
	WORKING,
	DONE
}

var current_state: MachineState = MachineState.IDLE
var processing_time: float = 5.0
var timer: Timer

# Signals
signal machine_done

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(processing_done)

func start_processing() -> void:
	if current_state == MachineState.IDLE:
		current_state = MachineState.WORKING
		timer.start(processing_time)
		print("working")

func processing_done() -> void:
	current_state = MachineState.DONE
	emit_signal("machine_done")
	print("done")
	
func reset_machine() -> void:
	current_state = MachineState.IDLE


