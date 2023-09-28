class_name Counter extends Interactable

var item: Node2D = null

func _ready():
	add_to_group("Placeable")

func interact():
	pass

func set_item(object):
	item = object
