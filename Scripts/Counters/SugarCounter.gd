extends Counter

var sugar  = load("res://Components/Holdable/Sugar.tscn")

func _ready():
	add_to_group("Dispenser")
	set_shader_material()

func _process(_delta):
	if !item:
		newItem()

func newItem():
	item = sugar.instantiate()
