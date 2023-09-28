class_name Player extends CharacterBody2D

const SPEED = 100
var all_interactions = []
var held_item: Node2D = null

@onready var animationPlayer = $AnimationPlayer
@onready var interactableFinder = $Direction/InteractableFinder
@onready var hand = $Hand

func _physics_process(delta):
	var input_vector = Vector2.ZERO
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
	
	if Input.is_action_just_pressed("interact") && all_interactions:
		execute_interaction(all_interactions[0]) # no issues with this yet so im keeping it

func execute_interaction(currInteraction):
	currInteraction.label = currInteraction.to_string()
	if !held_item:
		if currInteraction is Pickupable:
			currInteraction.hand = hand
			held_item = currInteraction
			currInteraction.pickup()
		elif (currInteraction is Counter or currInteraction is Machine) && currInteraction.item:
			currInteraction.item.hand = hand
			held_item = currInteraction.item
			currInteraction.item.pickup()
			currInteraction.item = null
		else:
			currInteraction.interact()
	else:
		if currInteraction is Counter or currInteraction is Machine: # or maybe a certain group? idk yet
			if !currInteraction.item: # drop item
				hand.remove_child(held_item)
				currInteraction.add_child(held_item)
				currInteraction.item = held_item
				held_item.global_position = currInteraction.global_position
				held_item = null
				currInteraction.interact()

########################
# Collision functions
########################
func _on_interactable_finder_area_entered(area):
	all_interactions.push_back(area)

func _on_interactable_finder_area_exited(area):
	all_interactions.erase(area)
