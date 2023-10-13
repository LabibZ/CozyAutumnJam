class_name CoffeeCupCounter extends Counter

var coffeeCup  = load("res://Components/Holdable/Cup/CoffeeCup.tscn")

func _ready():
	add_to_group("Dispenser")
	set_shader_material()

func _process(_delta):
	if !item:
		newItem()

func newItem():
	item = coffeeCup.instantiate()
