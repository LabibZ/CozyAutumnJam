class_name BoilingPot extends Pickupable

@onready var testTimer = $Time
var boiled: bool = false

func _process(delta):
	testTimer.text = "%0.2f" % timer.time_left

