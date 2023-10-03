class_name Player extends CharacterBody2D

const SPEED = 100
var all_interactions = []
var held_item: Holdable = null
var input_vector: Vector2 = Vector2.ZERO

@onready var animationPlayer = $AnimationPlayer
@onready var interactableFinder = $Direction/InteractableFinder
@onready var hand = $Hand

func _physics_process(_delta):
	move_player()
	
	# Interact with latest object that entered the interaction zone
	if Input.is_action_just_pressed("interact") and all_interactions:
		execute_interaction(all_interactions[0]) # no issues with this yet so im keeping it

# Player movement
func move_player():
	input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationPlayer.play("Run")
		velocity = input_vector * SPEED
	else:
		animationPlayer.play("Idle")
		velocity = Vector2.ZERO
	
	set_velocity(velocity)
	move_and_slide()

func execute_interaction(currInteraction):
	currInteraction.label = currInteraction.to_string() # for testing
	if held_item:
		handle_item_interaction(currInteraction)
	else:
		handle_noitem_interaction(currInteraction)

# Handle interactions when player is holding item
func handle_item_interaction(currInteraction):
	if !currInteraction.is_in_group("Placeable"):
		return
		
	if !currInteraction.item: # drop item
		if currInteraction is Table:
			if (currInteraction.interact(held_item)):
				held_item.drop(hand, currInteraction)
				held_item = null
		else:
			held_item.drop(hand, currInteraction)
			held_item = null
			currInteraction.interact()
	else:
		# item interactions
		# for now, manually do them, but add a helper function later
		if currInteraction.item is Cup and held_item is BoilingPot:
			if held_item.current_state == BoilingPot.BoilingState.BOILED:
				currInteraction.item.fill()
				held_item.current_state = BoilingPot.BoilingState.EMPTY
		elif currInteraction.item is Cup and held_item is Ingredient:
			currInteraction.item.add(held_item.getIngredient())
			held_item.queue_free()
			held_item = null

# Handle interactions when player is not holding an item
func handle_noitem_interaction(currInteraction):
	if currInteraction.is_in_group("Placeable") and currInteraction.item: # pickup item
		held_item = currInteraction.item
		held_item.pickup(hand)
		currInteraction.item = null
	if currInteraction.is_in_group("Dispenser"):
		print(currInteraction.item)
		held_item = currInteraction.item
		held_item.pickup(hand)
		currInteraction.item = null
	else:
		print("interacted with object with no class attached or case not made.")
		currInteraction.interact()

########################
# Collision functions
########################
func _on_interactable_finder_area_entered(area):
	print(area)
	all_interactions.push_back(area)

func _on_interactable_finder_area_exited(area):
	all_interactions.erase(area)
