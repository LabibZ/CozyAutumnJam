class_name BoilingPot extends Holdable

@onready var testTimer = $Time
var boiled: bool = false

func _process(_delta):
	testTimer.text = "%0.2f" % timer.time_left
