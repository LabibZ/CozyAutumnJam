class_name Cup extends Holdable

var filled: bool = false

func fill():
	filled = true
	print("cup filled")

func empty():
	filled = false
