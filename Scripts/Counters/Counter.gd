class_name Counter extends Interactable

@export var item: Holdable
#@onready var dropPoint = $DropPoint

func _ready():
	super()
	add_to_group("Placeable")

func interact():
	pass

func set_item(object):
	item = object
