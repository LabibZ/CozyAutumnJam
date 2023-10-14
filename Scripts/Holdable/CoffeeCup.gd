class_name CoffeeCup extends Cup

@onready var timerBar: ProgressBar = $TimerBar
@onready var steam = $Steam
@onready var steamPlayer = $Steam/AnimationPlayer

var emptyCup = Rect2(18, 1, 12, 14)
var fillCup = Rect2(2, 1, 12, 14)

func _ready():
	super()
	processing_time = 5.0
	timerBar.set_max(processing_time)

func _process(_delta):
	timerBar.value = timer.time_left

func fill():
	super()
	get_node(".").region_rect = fillCup
	order._base = "Coffee"
	steam.visible = true
	steamPlayer.play("steam")

func empty():
	super()
	dump()
	get_node(".").region_rect = emptyCup
	steam.stop()
	steam.visible = false
