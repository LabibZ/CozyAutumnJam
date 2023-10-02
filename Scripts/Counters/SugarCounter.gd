extends Counter

var sugar  = load("res://Components/Holdable/Sugar.tscn")

func _ready():
	add_to_group("Dispenser")

func _process(delta):
	if !item:
		newItem()

func newItem():
	item = sugar.instantiate()
