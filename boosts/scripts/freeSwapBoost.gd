extends Node2D

onready var singleHighlight : Sprite = $"singleHighlight"
onready var sprite0 : Sprite = $"sprite0"
onready var sprite1 : Sprite = $"sprite1"
onready var animator : AnimationPlayer = $"animator"
onready var confirm : AudioStreamPlayer = $"confirm"
onready var deny : AudioStreamPlayer = $"deny"


var board
var button

var state = 0
var firstCoord = null
var firstPiece = null

func swapPieces(coordSelect):
	if is_instance_valid(firstPiece):
		firstPiece.setSelect(firstPiece.UNSELECTED)
	
	var secondPiece = board.board[coordSelect.y][coordSelect.x]
	if is_instance_valid(secondPiece):
		secondPiece.setState(secondPiece.INCREMENT_STATE)
		secondPiece.position = board.getPos(firstCoord.x, firstCoord.y)
	firstPiece.setState(firstPiece.INCREMENT_STATE)
	firstPiece.position = board.getPos(coordSelect.x, coordSelect.y)
	
	board.board[coordSelect.y][coordSelect.x] = firstPiece
	board.board[firstCoord.y][firstCoord.x] = secondPiece

func setReturnAnimation():
	var returnAnimation = animator.get_animation("returnToButton")
	returnAnimation.track_set_key_value(0, 0, self.position)
	returnAnimation.track_set_key_value(0, 1, button.posNode.global_position)

func alertButton():
	button.displayUsage()

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
	if event is InputEventMouseButton &&\
	event.is_action_released("ui_select"):
		var coordSelect = getCoord(event.position)
		
		if state == 0 && coordSelect.x < board.brdWd && coordSelect.x >= 0 \
		&& coordSelect.y < board.brdHt && coordSelect.y >= 0 \
		&& is_instance_valid(board.board[coordSelect.y][coordSelect.x]):
			firstCoord = coordSelect
			firstPiece = board.board[coordSelect.y][coordSelect.x]
			firstPiece.setSelect(firstPiece.SOLO_SELECTED)
			state = 1
			sprite0.visible = false
			sprite1.visible = true
		elif state == 1 && coordSelect.x < board.brdWd && coordSelect.x >= 0 \
		&& coordSelect.y < board.brdHt && coordSelect.y >= 0:
			swapPieces(coordSelect)
			state = 2
			self.queue_free()
		elif state != 2:
			state == 2
			if is_instance_valid(firstPiece):
				firstPiece.setSelect(firstPiece.UNSELECTED)
			setReturnAnimation()
			animator.play("returnToButton")
			singleHighlight.visible = false
	
	if event is InputEventMouseMotion and state != 2:
		var coordSelect = getCoord(event.position)
		self.position = event.position
		
		if state == 0 && coordSelect.x < board.brdWd && coordSelect.x >= 0 \
		&& coordSelect.y < board.brdHt && coordSelect.y >= 0 \
		&& is_instance_valid(board.board[coordSelect.y][coordSelect.x]):
			singleHighlight.visible = true
			singleHighlight.global_position =\
			Vector2(board.brdX + (coordSelect.x * board.pieceSize), board.brdY + (coordSelect.y * board.pieceSize))
		
		elif state == 1 && coordSelect.x < board.brdWd && coordSelect.x >= 0 \
		&& coordSelect.y < board.brdHt && coordSelect.y >= 0:
			singleHighlight.visible = true
			singleHighlight.global_position =\
			Vector2(board.brdX + (coordSelect.x * board.pieceSize), board.brdY + (coordSelect.y * board.pieceSize))
		
		else:
			singleHighlight.visible = false
