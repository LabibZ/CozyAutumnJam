class_name Machine extends Interactable

enum MachineState {
	IDLE,
	WORKING,
	DONE
}

var current_state: MachineState = MachineState.IDLE
var item: Node2D = null

func interact():
	pass
#	if !item:
#		return
#
#	if current_state == MachineState.IDLE:
#		start_processing()
#	elif current_state == MachineState.DONE:
#		reset_machine()

func set_item(object):
	item = object

func start_processing() -> void:
	current_state = MachineState.WORKING
	item.start_timer()
	print("working")

func processing_done() -> void:
	current_state = MachineState.DONE
	print("done")
	
func reset_machine() -> void:
	current_state = MachineState.IDLE
	print("idle")
