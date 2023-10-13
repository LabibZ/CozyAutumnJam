class_name Interactable extends Area2D

var label: String
@onready var InteractMaterial = preload("res://InteractMaterial.tres")
@onready var sprite: Sprite2D = $Sprite2D

func _ready():
	set_shader_material()

func interact() -> void:
	#print("interact with " + label)
	pass

########################
# Shader Functions
########################
func set_shader_material():
	sprite.material = InteractMaterial.duplicate(true)

func set_shader():
	if sprite.material:
		sprite.material.set_shader_parameter("tint_strength", 0.25)

func reset_shader():
	if sprite.material:
		sprite.material.set_shader_parameter("tint_strength", 0.0)
