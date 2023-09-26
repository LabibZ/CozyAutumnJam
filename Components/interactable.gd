extends Area2D
class_name Interactable

signal interacted()
var label: String

func interact():
	print("interact with " + label)
