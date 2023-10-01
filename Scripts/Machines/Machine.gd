class_name Machine extends Interactable

enum MachineState {
	IDLE,
	WORKING,
	DONE
}

var current_state: MachineState = MachineState.IDLE
var item: Node2D = null

func _ready():
	add_to_group("Placeable")

# Called by player
func interact():
	if !check_requirements():
		return

	if current_state == MachineState.IDLE:
		start_processing()
	elif current_state == MachineState.DONE:
		reset_machine()

func check_requirements() -> bool:
	return item != null
	
func set_item(object):
	item = object

func start_processing() -> void:
	current_state = MachineState.WORKING
	item.start_timer()
	item.timerBar.visible = true
	print("working")

func processing_done() -> void:
	current_state = MachineState.DONE
	item.timerBar.visible = false
	print("done")
	
func reset_machine() -> void:
	current_state = MachineState.IDLE
	print("idle")
