class_name Pickupable extends Interactable

var hand: Node2D
var timer: Timer
var processing_time: float = 5.0
@onready var collision = $CollisionShape2D

func _ready():
	init_timer()
	if get_parent() is Machine or get_parent() is Counter:
		disable_collision()
		get_parent().set_item(self)

func pickup():
	if get_parent() is Machine:
		get_parent().reset_machine()
	
	get_parent().remove_child(self)
	hand.add_child(self)
	self.position = hand.position
	disable_collision()
	stop_timer()

#func drop():
#	# add drop off point
#	get_parent().remove_child(self)
#	hand.get_parent().get_parent().add_child(self) # TODO: clean?
#	self.global_position = hand.global_position
#	# enable collision after dropped
#	# collision.disabled = false
#	print(self.position)

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
# Collision Functions
########################
func disable_collision():
	collision.disabled = true

func enable_collision():
	collision.disabled = false
