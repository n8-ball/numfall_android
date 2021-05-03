extends Node2D

onready var spawner : Node2D = $"spawner"
onready var selector : Node2D = $"selector"
onready var saveLoad : Node2D = $"saveLoad"
onready var menu : CanvasLayer = $"menu"
onready var achievements : CanvasLayer = $"achievements"
onready var tutorial : CanvasLayer = $"tutorial"
onready var musicPlayer : AudioStreamPlayer = $"music"

var pieceName = load("res://pieceSets/default/scenes/default.tscn")

var board = []
const brdWd = 6
const brdHt = 10
var brdX = 120
var brdY = 280
const pieceSize = 200

var smallPiece = null
var bigPiece = null
var scheduleSpawn = false
var swapReady = false
var saveReady = false

var score = 0
var highScore = 0
var startPieces = 4

var musicOn = true
var soundOn = true
var tutorialOn = true

var savePiece = "default"
var saveMusic = "default"
var saveBackground = "default"

var gameOver = false
var tutorialStarted = false
signal swapMade

# Called when the node enters the scene tree for the first time.
func _ready():
	createBoard()
	if !saveLoad.loadInitial():
		menu.customize.setCustomize("default", "default", "default")
	menu.forceSettings()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	updateBoard()
	if Input.is_action_just_pressed("ui_accept"):
		var dir = Directory.new()
		dir.remove("user://numfall.save")
	if Input.is_action_just_pressed("ui_cancel"):
		for i in range(6):
			for j in range(10):
				if !(board[j][i] == null):
					board[j][i].setValue(board[j][i].getValue() + 1)
		#for _i in range(6):
		#	spawner.spawnPiece()
	if Input.is_action_pressed("ui_cancel"):
		score = score + 1

func clearBoard(): 
	for y in range(brdHt):
		for x in range(brdWd):
			if !isEmpty(x, y):
				board[y][x].setState(board[y][x].DELETE_STATE)
				board[y][x] = null
	spawner.rangeDisplay.clearRange()

func isClear():
	for y in range(brdHt):
		for x in range(brdWd):
			if isEmpty(x, y):
				return false
	return true

func restartGame():
	clearBoard()
	score = 0
	spawner.resetRange()
	setGameOver(false)
	spawner.rangeDisplay.newRange()
	tutorialStarted = tutorialOn
	tutorial.restart()
	if !tutorialStarted:
		for _i in range(startPieces):
			spawner.spawnPiece()
	else:
		spawner.makePiece(2, 0, 0)
		spawner.makePiece(1, 2, 0)
		spawner.makePiece(1, 3, 0)
		spawner.makePiece(2, 5, 0)
	saveLoad.saveGame()

func endGame():
	setGameOver(true)
	cancelSave()
	saveLoad.saveGame()
	menu.endGameMenu()

func createBoard():
	for y in range(brdHt):
		board.append([])
		for _x in range(brdWd):
			board[y].append(null)

func updateBoard():
	var tempSmall = null
	var tempBig = null
	var allReady = true
	var topRow = getTopRow()
	swapReady = true
	for y in range(brdHt - 1, topRow - 1, -1):
		for x in range(brdWd):
			#Normal
			var curPiece = board[y][x]
			var chkPiece
			if y+1 >= brdHt:
				chkPiece = null
			else:
				chkPiece = board[y+1][x]
			if curPiece != null:
				tempSmall = checkSmall(tempSmall, curPiece)
				tempBig = checkBig(tempBig, curPiece)
				handlePiece(curPiece, chkPiece, x, y, allReady)
				allReady = checkReady(allReady, curPiece)
	smallPiece = tempSmall
	bigPiece = tempBig
	if swapReady && saveReady:
		achievements.checkStableAchievements()
		saveLoad.saveGame()
		saveReady = false
	if scheduleSpawn && allReady:
		scheduleSpawn = false
		if !tutorialStarted:
			spawner.spawnPiece()
		else:
			spawner.makePiece(2, 5, 0)
		saveReady = true

#Optimization
func getTopRow():
	for y in range(brdHt):
		for x in range(brdWd):
			if board[y][x] != null:
				return y
	return 0

func checkBig(chkNum, chkPiece):
	if chkNum == null:
		if chkPiece != null:
			return chkPiece.getValue()
		else:
			return null
	elif chkPiece != null:
		if chkPiece.getValue() > chkNum:
			return chkPiece.getValue()
		else:
			return chkNum
	return null

func checkSmall(chkNum, chkPiece):
	if chkNum == null:
		if chkPiece != null:
			return chkPiece.getValue()
		else:
			return null
	elif chkPiece != null:
		if chkPiece.getValue() < chkNum:
			return chkPiece.getValue()
		else:
			return chkNum
	return null

func handlePiece(curPiece, chkPiece, x, y, allReady):
	# Combine
	if curPiece.comparePiece(chkPiece) == 0 && curPiece.isReady()\
	&& chkPiece.isReady() && y < brdHt - 1:
		curPiece.setState(curPiece.COMBINE_TOP_STATE)
		chkPiece.setState(chkPiece.COMBINE_BOT_STATE)
		curPiece.setPos(getPos(x, y+1))
		score += curPiece.getModifiedScore()
		if score > highScore:
			highScore = score
		board[y+1][x] = curPiece
		board[y][x] = null
	# Fall
	elif curPiece.comparePiece(chkPiece) == -1 && curPiece.isReady()\
	&& y < brdHt - 1 && allReady:
		curPiece.setState(curPiece.FALL_STATE)
		curPiece.setPos(getPos(x, y+1))
		board[y+1][x] = curPiece
		board[y][x] = null
	# Landing/Idle
	elif (curPiece.comparePiece(chkPiece) == 1 || y >= brdHt - 1)\
	&& curPiece.isReady():
		if curPiece.getState() == curPiece.FALL_STATE:
			curPiece.setState(curPiece.LAND_STATE)
		else:
			curPiece.setState(curPiece.IDLE_STATE)

func checkReady(chkReady, chkPiece):
	if chkPiece.getState() != chkPiece.IDLE_STATE\
	&& chkPiece.getState() != chkPiece.LAND_STATE:
		swapReady = false
	if chkReady == false:
		return false
	else:
		return chkPiece.isReady()

func swapPieces(firstCoord, secondCoord):
	var firstPiece = board[firstCoord.y][firstCoord.x]
	var secondPiece = board[secondCoord.y][secondCoord.x]
	
	board[firstCoord.y][firstCoord.x] = secondPiece
	board[secondCoord.y][secondCoord.x] = firstPiece
	
	if firstPiece != null:
		if firstCoord.x > secondCoord.x:
			firstPiece.setState(firstPiece.SWITCH_RIGHT_STATE)
		else:
			firstPiece.setState(firstPiece.SWITCH_LEFT_STATE)
		firstPiece.setPos(getPos(secondCoord.x, secondCoord.y))
	if secondPiece != null:
		if secondCoord.x > firstCoord.x:
			secondPiece.setState(secondPiece.SWITCH_RIGHT_STATE)
		else:
			secondPiece.setState(secondPiece.SWITCH_LEFT_STATE)
		secondPiece.setPos(getPos(firstCoord.x, firstCoord.y))
	scheduleSpawn = true
	emit_signal("swapMade")

func getPos(x, y):
# warning-ignore:integer_division
	var newX = brdX + (pieceSize * x) + (pieceSize/2)
	var newY = brdY + (pieceSize * (y+1))
	var newPos = Vector2(newX, newY)
	return newPos

func isEmpty(x, y):
	return board[y][x] == null

func getPieceType():
	return pieceName

func saveBoard():
	var simpBoard = []
	simpBoard.resize(brdHt * brdWd)
	for y in range(brdHt):
		for x in range(brdWd):
			if !isEmpty(x, y):
				simpBoard[(y*brdWd) + x] = board[y][x].getValue()
			else:
				simpBoard[(y*brdWd) + x] = 0
	var saveDict = {
		"score" : score,
		"board" : simpBoard,
		"highScore" : highScore
	}
	return saveDict

func loadBoard(newBoard):
	for y in range(brdHt):
		for x in range(brdWd):
			if !isEmpty(x, y):
				board[y][x].queue_free()
			if newBoard[(y*brdWd) + x] == 0:
				board[y][x] = null
			else:
				spawner.makePiece(newBoard[(y*brdWd) + x], x, y)
	

func loadScore(newScore):
	score = newScore

func loadHighScore(newHighScore):
	highScore = newHighScore

func saveSettings():
	var saveDict = {
		"music" : musicOn,
		"sound" : soundOn,
		"tutorial" : tutorialOn,
		"gameOver" : gameOver,
		"savePiece" : savePiece,
		"saveMusic" : saveMusic,
		"saveBackground" : saveBackground
	}
	return saveDict

func loadSettings(newSettings):
	if newSettings.has("music"):
		setMusic(newSettings["music"])
	if newSettings.has("sound"):
		setSound(newSettings["sound"])
	if newSettings.has("tutorial"):
		setTutorial(newSettings["tutorial"])
	if newSettings.has("gameOver"):
		setGameOver(newSettings["gameOver"])
	if newSettings.has("savePiece") && newSettings.has("saveMusic")\
		&& newSettings.has("saveBackground"):
		menu.customize.setCustomize(newSettings["savePiece"],\
		newSettings["saveMusic"], newSettings["saveBackground"])

func getMusic():
	return musicOn

func setMusic(newMusic):
	musicOn = newMusic

func getSound():
	return soundOn

func setSound(newSound):
	soundOn = newSound

func getTutorial():
	return tutorialOn

func setTutorial(newTutorial):
	tutorialOn = newTutorial
	if tutorialOn == false:
		tutorialStarted = false

func getTutorialStarted():
	return tutorialStarted

func getGameOver():
	return gameOver

func setGameOver(newGameOver):
	gameOver = newGameOver

func changePiece(newPieceName, newSavePiece):
	pieceName = load(newPieceName)
	savePiece = newSavePiece

func changeMusic(newMusic, newSaveMusic):
	var newSong = load(newMusic)
	musicPlayer.stream = newSong
	musicPlayer.play(0)
	saveMusic = newSaveMusic

func setSaveBackground(newSaveBackground):
	saveBackground = newSaveBackground

func cancelSave():
	saveReady = false
