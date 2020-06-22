extends Node2D

onready var board : Node2D = $".."

var newPieceName = load("res://pieceSets/pixel/scenes/pixel.tscn")

var rng = RandomNumberGenerator.new()

var floorNum = 1
var floorPot = 1
var ceilNum = 4

func _ready():
	rng.randomize()

func findRange():
	if board.bigPiece - 3 > ceilNum:
		ceilNum = board.bigPiece - 3
	if (board.bigPiece/2) - 1 > floorPot:
		floorPot = (board.bigPiece/2) - 1
	if board.smallPiece > floorNum && floorNum < floorPot:
		floorNum += 1
	if board.smallPiece < floorNum:
		floorNum = board.smallPiece

func spawnPiece():
	findRange()
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
		for j in range(numOptions - 1, -1, -1):
			if pieceChoice <= oddsTable[j]:
				makePiece(floorNum + j, rng.randi_range(0, board.brdWd-1))
				break
		
		print(oddsTable)

func makePiece(value, xPos):
	var newPiece = newPieceName.instance()
	newPiece.setValue(value)
	board.add_child(newPiece)
	board.board[0][xPos] = newPiece
	newPiece.setState(newPiece.SPAWN_STATE)
	newPiece.setPos(board.getPos(xPos, 0))
