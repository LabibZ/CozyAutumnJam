extends Node2D

var bodyPath = "res://Assets/CharacterGeneration/Body/"
var outfitPath = "res://Assets/CharacterGeneration/Outfits/"
var hairPath = "res://Assets/CharacterGeneration/Hair/"
var eyesPath = "res://Assets/CharacterGeneration/Eyes/"
var bodySprites = []
var outfitSprites = []
var hairSprites = []
var eyesSprites = []

func _ready():
	loadImagesFromDir(bodySprites, bodyPath)
	loadImagesFromDir(outfitSprites, outfitPath)
	loadImagesFromDir(hairSprites, hairPath)
	loadImagesFromDir(eyesSprites, eyesPath)

func loadImagesFromDir(list, path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !file_name.begins_with(".") and !file_name.ends_with(".import"):
				list.append(load(path + "/" + file_name))
			file_name = dir.get_next()
		dir.list_dir_end()
	

func GenerateCharacter(body: Sprite2D, outfit: Sprite2D, hair: Sprite2D, eyes: Sprite2D):
	GenerateBody(body)
	GenerateOutfit(outfit)
	GenerateHair(hair)
	GenerateEyes(eyes)
	
func GenerateBody(body: Sprite2D):
	var index = randi_range(0, bodySprites.size() - 1)
	body.texture = bodySprites[index]
	
func GenerateOutfit(outfit: Sprite2D):
	var index = randi_range(0, outfitSprites.size() - 1)
	outfit.texture = outfitSprites[index]

func GenerateHair(hair: Sprite2D):
	var index = randi_range(0, hairSprites.size() - 1)
	hair.texture = hairSprites[index]

func GenerateEyes(eyes: Sprite2D):
	var index = randi_range(0, eyesSprites.size() - 1)
	eyes.texture = eyesSprites[index]
