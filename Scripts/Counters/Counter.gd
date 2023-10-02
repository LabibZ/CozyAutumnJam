class_name Counter extends Interactable

@export var item: Holdable

func _ready():
	add_to_group("Placeable")

func interact():
	pass

func set_item(object):
	item = object
