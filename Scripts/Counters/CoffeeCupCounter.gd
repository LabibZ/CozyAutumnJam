extends Counter

var coffeeCup  = load("res://Components/Holdable/Cup/CoffeeCup.tscn")

func _ready():
	add_to_group("Dispenser")

func _process(_delta):
	if !item:
		newItem()

func newItem():
	item = coffeeCup.instantiate()
