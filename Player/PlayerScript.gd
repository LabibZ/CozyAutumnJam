extends CharacterBody2D

class_name Player

const SPEED = 100
var all_interactions = []

@onready var animationPlayer = $AnimationPlayer
@onready var interactableFinder = $Marker2D/InteractableFinder

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
	
	if Input.is_action_just_pressed("interact"):
		execute_interaction()

#func check_nearest_interactable(nearest_interactable) -> void:
#	var areas: Array[Area2D] = interactableFinder.get_overlapping_areas()
#	var shortest_distance: float = INF
#	var next_nearest_interactable: Interactable = null
#	for area in areas:
#		var distance: float = area.global_position.distance_to(global_position)
#		if distance < shortest_distance:
#			shortest_distance = distance
#			next_nearest_interactable = area
#	if next_nearest_interactable != nearest_interactable or not is_instance_valid(next_nearest_interactable):
#		nearest_interactable = next_nearest_interactable
#		emit_signal("nearest_actionable_changed", nearest_interactable)
#	print("interactable")
#	print(nearest_interactable)


func _on_interactable_finder_area_entered(area):
	all_interactions.push_back(area)


func _on_interactable_finder_area_exited(area):
	all_interactions.erase(area)

func execute_interaction():
	if all_interactions:
		var currInteraction = all_interactions[0]
		currInteraction.label = currInteraction.to_string()
		currInteraction.interact()
