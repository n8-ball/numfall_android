extends Node2D

onready var board : Node2D = $".."
onready var achievents : CanvasLayer = $"../achievements"

func _ready():
	pass

func loadGame():
	var saveFile = File.new()
	if !saveFile.file_exists("user://numfall.save"):
		return false
	saveFile.open("user://numfall.save", File.READ)
	var boardDict = parse_json(saveFile.get_line())
	board.loadScore(boardDict["score"])
	board.loadBoard(boardDict["board"])
	var achieveDict = parse_json(saveFile.get_line())
	achievents.loadAchieve(achieveDict)
	return true

func saveGame():
	var boardData = board.saveBoard()
	var achieveData = achievents.saveAchieve()
	var saveFile = File.new()
	saveFile.open("user://numfall.save", File.WRITE)
	saveFile.store_line(to_json(boardData))
	saveFile.store_line(to_json(achieveData))
	saveFile.close()
