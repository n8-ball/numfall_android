extends Node2D

onready var spawner : Node2D = $"spawner"
onready var selector : Node2D = $"selector"

var newPieceName = load("res://pieceSets/pixel/scenes/pixel.tscn")

var board = []
const brdWd = 6
const brdHt = 10
const brdX = 120
const brdY = 300
const pieceSize = 200

var smallPiece = null
var bigPiece = null
var scheduleSpawn = false
var swapReady = false

# Called when the node enters the scene tree for the first time.
func _ready():
	createBoard()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updateBoard()
	if Input.is_action_just_pressed("ui_accept"):
		var newPiece = newPieceName.instance()
		self.add_child(newPiece)
		board[0][0] = newPiece
		newPiece.setState(newPiece.SPAWN_STATE)
		newPiece.setPos(getPos(0, 0))

func createBoard():
	for y in range(brdHt):
		board.append([])
		for x in range(brdWd):
			board[y].append(null)

func updateBoard():
	var tempSmall = null
	var tempBig = null
	var allReady = true
	swapReady = true
	for y in range(brdHt - 1, -1, -1):
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
	if scheduleSpawn && allReady:
		scheduleSpawn = false
		spawner.spawnPiece()

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
	if curPiece.comparePiece(chkPiece) == 0 && curPiece.isReady() && chkPiece.isReady()\
	&& y < brdHt - 1:
		curPiece.setState(curPiece.COMBINE_TOP_STATE)
		chkPiece.setState(chkPiece.COMBINE_BOT_STATE)
		curPiece.setPos(getPos(x, y+1))
		board[y+1][x] = curPiece
		board[y][x] = null
	# Fall
	elif curPiece.comparePiece(chkPiece) == -1 && curPiece.isReady() && y < brdHt - 1 && allReady:
		curPiece.setState(curPiece.FALL_STATE)
		curPiece.setPos(getPos(x, y+1))
		board[y+1][x] = curPiece
		board[y][x] = null
	# Landing/Idle
	elif (curPiece.comparePiece(chkPiece) == 1 || y >= brdHt - 1) && curPiece.isReady():
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

func getPos(x, y):
	var newX = brdX + (pieceSize * x) + (pieceSize/2)
	var newY = brdY + (pieceSize * (y+1))
	var newPos = Vector2(newX, newY)
	return newPos
