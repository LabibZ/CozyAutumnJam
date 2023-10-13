class_name Player extends CharacterBody2D

const SPEED = 100
var all_interactions = []
var closest_interaction = null
var held_item: Holdable = null
var input_vector: Vector2 = Vector2.ZERO

@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")
@onready var interactableFinder = $Direction/InteractableFinder
@onready var hand = $Hand
@onready var audioPlayer = $AudioStreamPlayer

var blopSound = load("res://Assets/Sounds/Effects/Blop.ogg")
var pourSound = load("res://Assets/Sounds/Effects/Pouring Tea.wav")

func _physics_process(_delta):
	move_player()
	
	if held_item and held_item.position != hand.position:
		held_item.position = hand.position
	
	# Interact with closest object that entered the interaction zone
	if Input.is_action_just_pressed("interact") and closest_interaction:
		execute_interaction(closest_interaction)

# Player movement
func move_player():
	input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationState.travel("Run")
		velocity = input_vector * SPEED
	else:
		animationState.travel("Idle")
		velocity = Vector2.ZERO
	
	set_velocity(velocity)
	move_and_slide()

func get_closest_interactable():
	if all_interactions.size() == 1:
		if check_obj(all_interactions[0]):
			return all_interactions[0]
		return null
	
	var closest = INF
	var closest_interactable = null
	for obj in all_interactions:
		if !check_obj(obj):
			continue
		var dist = interactableFinder.global_position.distance_to(obj.global_position)
		if dist < closest:
			closest = dist
			closest_interactable = obj
	return closest_interactable

func check_obj(obj):
	if held_item:
		if held_item is CoffeeCup and obj is CoffeeCupCounter:
			return not held_item.filled
		if held_item is TeaCup and obj is TeaCupCounter:
			return not held_item.filled
		if !obj.is_in_group("Placeable") and not obj is Trash:
			return false
		if held_item is Ingredient and obj.item is Cup:
			return true
		if held_item is BoilingPot and obj.item is TeaCup:
			return true
		if held_item is BoilingPot and obj is Trash:
			return false
		if obj.item:
			return false
		return true
	else:
		if obj is Table and obj.current_state == obj.TableState.ORDERS_NOT_TAKEN:
			return true
		if (obj.is_in_group("Placeable") or obj.is_in_group("Dispenser")) and obj.item:
			return true
		return false

func execute_interaction(currInteraction):
	# currInteraction.label = currInteraction.to_string() # for testing
	if held_item:
		handle_item_interaction(currInteraction)
	else:
		handle_noitem_interaction(currInteraction)

# Handle interactions when player is holding item
func handle_item_interaction(currInteraction):
	if (currInteraction is CoffeeCupCounter and held_item is CoffeeCup) or \
	(currInteraction is TeaCupCounter and held_item is TeaCup):
		held_item.queue_free()
		held_item = null
		return
	if !currInteraction.is_in_group("Placeable") and not currInteraction is Trash:
		return
		
	if currInteraction is Trash:
		if held_item is Cup:
			held_item.empty()
		elif held_item is BoilingPot:
			return
		else:
			held_item.queue_free()
			held_item = null
		return
	elif currInteraction is Table:
		if currInteraction.interact(held_item):
			held_item.drop(hand, currInteraction)
			held_item = null
		return
	
	if !currInteraction.item: # drop item
		held_item.drop(hand, currInteraction)
		held_item = null
		currInteraction.interact()
	else:
		# item interactions
		# for now, manually do them, but add a helper function later
		if currInteraction.item is Cup and held_item is BoilingPot:
			if held_item.current_state == BoilingPot.BoilingState.BOILED:
				currInteraction.item.fill()
				playSound(pourSound)
				held_item.current_state = BoilingPot.BoilingState.EMPTY
		elif currInteraction.item is Cup and held_item is Ingredient:
			currInteraction.item.add(held_item.getIngredient())
			playSound(blopSound)
			held_item.queue_free()
			held_item = null

# Handle interactions when player is not holding an item
func handle_noitem_interaction(currInteraction):
	if currInteraction.is_in_group("Placeable") and currInteraction.item: # pickup item
		held_item = currInteraction.item
		held_item.pickup(hand)
		currInteraction.item = null
	elif currInteraction.is_in_group("Dispenser"):
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
	all_interactions.push_back(area)
	update_closest_interaction()

func _on_interactable_finder_area_exited(area):	
	if area.is_in_group("Dispenser"):
		area.reset_shader()
	elif area.is_in_group("Placeable") and area.item:
		area.item.reset_shader()
	else:
		area.reset_shader()
	all_interactions.erase(area)

func update_closest_interaction():
	if closest_interaction:
		closest_interaction.reset_shader()
		
	closest_interaction = get_closest_interactable()
	if !closest_interaction:
		return
	
	if closest_interaction.is_in_group("Dispenser"):
		closest_interaction.set_shader()
	elif closest_interaction.is_in_group("Placeable") and closest_interaction.item:
		closest_interaction.item.set_shader()
	else:
		closest_interaction.set_shader()

func playSound(sound):
	audioPlayer.stream = sound
	audioPlayer.play()
