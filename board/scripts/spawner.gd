extends Node2D

onready var board : Node2D = $".."
onready var rangeDisplay : Node2D = $"range"

var rng = RandomNumberGenerator.new()

const initFloor = 1
const initCeil = 2

var floorNum = initFloor
var floorPot = 0
var ceilNum = initCeil

func _ready():
	rng.randomize()

func _process(_delta):
	if board != null && board.bigPiece != null && board.smallPiece != null:
		findRange()

func findRange():
	if board.bigPiece - 3 > ceilNum:
		ceilNum = board.bigPiece - 3
	if int(board.bigPiece/2) - 4 + int(sqrt(board.bigPiece)) > floorPot:
		floorPot = int(board.bigPiece/2) - 4 + int(sqrt(board.bigPiece))
	if board.smallPiece > floorNum && floorNum < floorPot:
		floorNum += 1
	if board.smallPiece < floorNum:
		floorNum = board.smallPiece

func spawnPiece():
	var freeSpace = false
	for x in range(board.brdWd):
		if board.board[0][x] == null:
			freeSpace = true
	
	if freeSpace:
		var totShares = 0
		var numOptions = ceilNum - floorNum + 1
		var oddsTable = []
		oddsTable.resize(numOptions)
		var scaleFactor = int(max(1, sqrt(ceilNum - floorNum + 1) - 1))
		var scaleCnt = 0
		var curShare = 2
		
		for i in range(numOptions - 1, -1, -1):
			totShares += curShare
			oddsTable[i] = totShares
			scaleCnt += 1
			if scaleCnt >= scaleFactor:
				curShare += 1
				scaleCnt = 0
		
		var pieceChoice = (rng.randi_range(1, totShares))
		var coordChoice = rng.randi_range(0, board.brdWd-1)
		for j in range(numOptions - 1, -1, -1):
			if pieceChoice <= oddsTable[j]:
				while(!board.isEmpty(coordChoice, 0)):
					coordChoice = rng.randi_range(0, board.brdWd-1)
				makePiece(floorNum + j, coordChoice, 0)
				break
	else:
		board.endGame()

func makePiece(value, xPos, yPos):
	var newPiece = board.getPieceType().instance()
	newPiece.setValue(value)
	newPiece.setBoard(board)
	board.add_child(newPiece)
	board.board[yPos][xPos] = newPiece
	newPiece.setState(newPiece.SPAWN_STATE)
	newPiece.setPos(board.getPos(xPos, yPos))

func resetRange():
	floorNum = initFloor
	floorPot = 0
	ceilNum = initCeil
