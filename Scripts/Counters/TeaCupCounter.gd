extends Counter

var teaCup  = load("res://Components/Holdable/Cup/TeaCup.tscn")

func _ready():
	add_to_group("Dispenser")

func _process(_delta):
	if !item:
		newItem()

func newItem():
	item = teaCup.instantiate()
