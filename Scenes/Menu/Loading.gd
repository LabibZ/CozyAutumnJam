extends Control

var progress = []
var sceneName
var scene_load_status = 0

func _ready():
	sceneName = "res://Scenes/World.tscn"
	ResourceLoader.load_threaded_request(sceneName)
	
func _process(_delta):
	scene_load_status = ResourceLoader.load_threaded_get_status(sceneName, progress)
	$Label.text = str(floor(progress[0]*100)) + "%"
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var newScene = ResourceLoader.load_threaded_get(sceneName)
		get_tree().change_scene_to_packed(newScene)
