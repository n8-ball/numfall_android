extends Node2D

onready var board : Node2D = $".."
onready var achievents : CanvasLayer = $"../achievements"

func _ready():
	pass

func loadInitial():
	var saveFile = File.new()
	if !saveFile.file_exists("user://numfall.save"):
		return false
	saveFile.open("user://numfall.save", File.READ)
	var boardDict = parse_json(saveFile.get_line())
	if boardDict.has("score"):
		board.loadScore(boardDict["score"])
	if boardDict.has("highScore"):
		board.loadHighScore(boardDict["highScore"])
	var settingsData = parse_json(saveFile.get_line())
	board.loadSettings(settingsData)
	var achieveDict = parse_json(saveFile.get_line())
	achievents.loadAchieve(achieveDict)
	saveFile.close()
	return true

func loadGame():
	var saveFile = File.new()
	if !saveFile.file_exists("user://numfall.save"):
		return false
	saveFile.open("user://numfall.save", File.READ)
	var boardDict = parse_json(saveFile.get_line())
	if boardDict.has("score"):
		board.loadScore(boardDict["score"])
	if boardDict.has("highScore"):
		board.loadHighScore(boardDict["highScore"])
	if boardDict.has("board"):
		board.loadBoard(boardDict["board"])
	saveFile.close()
	return true

func saveGame():
	var boardData = board.saveBoard()
	var settingsData = board.saveSettings()
	var achieveData = achievents.saveAchieve()
	var saveFile = File.new()
	saveFile.open("user://numfall.save", File.WRITE)
	saveFile.store_line(to_json(boardData))
	saveFile.store_line(to_json(settingsData))
	saveFile.store_line(to_json(achieveData))
	saveFile.close()
