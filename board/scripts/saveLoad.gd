extends Node2D

onready var board : Node2D = $".."

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		saveBoard()
	if Input.is_action_just_pressed("ui_cancel"):
		loadBoard()

func loadBoard():
	var saveFile = File.new()
	if !saveFile.file_exists("user://numfall.save"):
		return false
	saveFile.open("user://numfall.save", File.READ)
	var saveDict = parse_json(saveFile.get_line())
	board.loadScore(saveDict["score"])
	board.loadBoard(saveDict["board"])
	return true

func saveBoard():
	var boardData = board.save()
	var saveFile = File.new()
	print(boardData)
	saveFile.open("user://numfall.save", File.WRITE)
	saveFile.store_line(to_json(boardData))
	saveFile.close()
