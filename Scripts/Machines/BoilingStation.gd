class_name BoilingStation extends Machine

func check_requirements() -> bool:
	if item is BoilingPot:
		if !item.boiled:
			return true
	return false

func processing_done():
	super()
	item.boiled = true
	print("pot boiled")
