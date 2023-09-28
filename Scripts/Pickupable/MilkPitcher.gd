class_name MilkPitcher extends Pickupable

#var isHeld: bool = false
#
#func interact():
#	if (isHeld):
#		# pour milk
#		# check collision
#		drop() # only on counters
#		print("dropped")
#	else:
#		pickup()
#		print("picked up")
#	isHeld = !isHeld
#
#func pickup():
#	self.position = hand.position
#	get_parent().remove_child(self)
#	hand.add_child(self)
#	# disable collision check
#	# collision.disabled = true
#	print(self.position)
#
#func drop():
#	# add drop off point
#	get_parent().remove_child(self)
#	hand.get_parent().get_parent().add_child(self) # TODO: clean?
#	self.global_position = hand.global_position
#	# enable collision after dropped
#	# collision.disabled = false
#	print(self.position)
