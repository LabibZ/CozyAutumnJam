extends Counter

var milk  = load("res://Components/Holdable/Milk.tscn")

func _ready():
	add_to_group("Dispenser")

func _process(delta):
	if !item:
		newItem()

func newItem():
	item = milk.instantiate()
