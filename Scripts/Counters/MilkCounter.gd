extends Counter

var milk  = load("res://Components/Holdable/Milk.tscn")

func _ready():
	add_to_group("Dispenser")
	set_shader_material()

func _process(_delta):
	if !item:
		newItem()

func newItem():
	item = milk.instantiate()
