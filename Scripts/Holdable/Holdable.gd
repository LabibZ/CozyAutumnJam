class_name Holdable extends Node2D

var timer: Timer
var processing_time: float = 5.0
var order: Order
@onready var InteractMaterial = preload("res://Scripts/InteractMaterial.tres")

func _ready():
	init_timer()
	# TODO: maybe use an @export on the placeable to set it from the scene
	# if get_parent().is_in_group("Placeable"):
	if get_parent() is Machine or get_parent() is Counter: # TODO errpr check spageti code
		get_parent().set_item(self)
	order = Order.new("", [])
	set_shader_material()

func pickup(hand):
	if get_parent() is Machine:
		get_parent().reset_machine()
	
	if get_parent():
		get_parent().set_shader()
		reset_shader()
		get_parent().remove_child(self)
	hand.add_child(self)
	self.position = hand.position
	stop_timer()

func drop(hand, placeable):
	hand.remove_child(self)
	placeable.add_child(self)
	placeable.set_item(self)
	placeable.reset_shader()
	if placeable is Table:
		reset_shader()
	elif placeable is Counter:
		set_shader()
	if placeable is Table or placeable is Sink:
		self.global_position = placeable.dropPoint
	else:
		self.global_position = placeable.global_position

func asOrder():
	return order

########################
# Timer Functions
########################
func init_timer():
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(timer_finished)

func start_timer():
	timer.start(processing_time)

func pause_timer():
	timer.set_paused(true)
	
func unpause_timer():
	timer.set_paused(false)

func stop_timer():
	timer.stop()
	
func timer_finished():
	stop_timer()
	get_parent().processing_done()

########################
# Shader Functions
########################
func set_shader_material():
	self.material = InteractMaterial.duplicate(true)

func set_shader():
	if self.material:
		self.material.set_shader_parameter("tint_strength", 0.25)

func reset_shader():
	if self.material:
		self.material.set_shader_parameter("tint_strength", 0.0)
