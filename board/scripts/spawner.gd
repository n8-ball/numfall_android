extends Node2D

onready var board : Node2D = $".."

var newPieceName = load("res://pieceSets/pixel/scenes/pixel.tscn")

var rng = RandomNumberGenerator.new()

var floorNum = 1
var floorPot = 1
var ceilNum = 4

func _ready():
	rng.randomize()

func _process(delta):
	if board != null && board.bigPiece != null && board.smallPiece != null:
		findRange()

func findRange():
	if board.bigPiece - 4 > ceilNum:
		ceilNum = board.bigPiece - 4
	if int(board.bigPiece/1.5) - 1 > floorPot:
		floorPot = int(board.bigPiece/1.5) - 1
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
		
		print(oddsTable)

func makePiece(value, xPos, yPos):
	var newPiece = newPieceName.instance()
	newPiece.setValue(value)
	board.add_child(newPiece)
	board.board[yPos][xPos] = newPiece
	newPiece.setState(newPiece.SPAWN_STATE)
	newPiece.setPos(board.getPos(xPos, yPos))

func resetRange():
	floorNum = 1
	floorPot = 1
	ceilNum = 4
