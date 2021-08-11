extends Node2D

onready var confirm : AudioStreamPlayer = $"confirm"
onready var deny : AudioStreamPlayer = $"deny"
onready var sprite : Sprite = $"sprite"

var board
var button

var firstPiece = null
var secondPiece = null

var firstPiecePos = null
var secondPiecePos = null

var scheduleDelete = false

# Called when the node enters the scene tree for the first time.
func _ready():
	confirm.connect("finished", self, "_delete")
	deny.connect("finished", self, "_delete")

func setBoard(newBoard):
	board = newBoard

func setButton(newButton):
	button = newButton

func getCoord(pos):
	var brdX = int(floor((pos.x - board.brdX)/board.pieceSize))
	var brdY = int(floor((pos.y - board.brdY)/board.pieceSize))
	var newCoord = Vector2(brdX, brdY)
	return newCoord

func _input(event):
	#First Piece
	if event is InputEventMouseButton &&\
	event.is_action_released("ui_select"):
		print("first")
		var coordSelect = getCoord(event.position)
		if coordSelect.x < board.brdWd && coordSelect.x >= 0 \
		&& coordSelect.y < board.brdHt && coordSelect.y >= 0 \
		&& is_instance_valid(board.board[coordSelect.y][coordSelect.x])\
		&& not scheduleDelete:
			print("firstConfirm")
			confirm.play()
			firstPiecePos = coordSelect
			firstPiece = board.board[coordSelect.y][coordSelect.x]
			firstPiece.setSelect(firstPiece.SOLO_SELECTED)
		elif not scheduleDelete:
			print("firstDelete")
			deny.play()
			button.displayUsage()
			scheduleDelete = true
		sprite.visible = false
	
	#Second Piece
	if event is InputEventMouseButton &&\
	event.is_action_pressed("ui_select"):
		print("second")
		var coordSelect = getCoord(event.position)
		if coordSelect.x < board.brdWd && coordSelect.x >= 0 \
		&& coordSelect.y < board.brdHt && coordSelect.y >= 0 \
		&& not scheduleDelete && is_instance_valid(firstPiece)\
		&& not ((firstPiecePos.x - coordSelect.x == 1 || firstPiecePos.x - coordSelect.x == -1 || firstPiecePos.x - coordSelect.x == 0)\
		&& firstPiecePos.y == coordSelect.y):
			print("secondConfirm")
			confirm.play()
			if is_instance_valid(board.board[coordSelect.y][coordSelect.x]):
				secondPiece = board.board[coordSelect.y][coordSelect.x]
			secondPiecePos = coordSelect
			firstPiece.setState(firstPiece.INCREMENT_STATE)
			firstPiece.setPos(board.getPos(secondPiecePos.x, secondPiecePos.y))
			board.board[secondPiecePos.y][secondPiecePos.x] = firstPiece
			if is_instance_valid(secondPiece):
				secondPiece.setState(secondPiece.INCREMENT_STATE)
				secondPiece.setPos(board.getPos(firstPiecePos.x, firstPiecePos.y))
			board.board[firstPiecePos.y][firstPiecePos.x] = secondPiece
			firstPiece.setSelect(firstPiece.UNSELECTED)
		elif is_instance_valid(firstPiece) && not scheduleDelete:
			print("secondDeny")
			deny.play()
			button.displayUsage()
			if is_instance_valid(firstPiece):
				firstPiece.setSelect(firstPiece.UNSELECTED)
		sprite.visible = false
		scheduleDelete = true
	
	if event is InputEventMouseMotion:
		self.position = event.position

func _delete():
	if scheduleDelete:
		self.queue_free()
