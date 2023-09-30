extends Node2D

var score
var time # maybe use SceneTree timer instaed of regualr Timer

signal level_started
signal level_ended

func _ready():
	setup_level()
	
func setup_level():
	# init level
	# init player pos
	# reset score, time
	# start orders
	emit_signal("level_started")

func end_level():
	emit_signal("level_ended")
	
