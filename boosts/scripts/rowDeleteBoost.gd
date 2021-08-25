extends Node2D

onready var rowHighlight : Sprite = $"rowHighlight"
onready var sprite : Sprite = $"sprite"
onready var animator : AnimationPlayer = $"animator"
onready var confirm : AudioStreamPlayer = $"confirm"
onready var deny : AudioStreamPlayer = $"deny"


var board
var button

var activated = false
var removeCoord = null
var posMod = 0
var negMod = 0

func deletePiece():
	var chkPieceA = null
	var chkPieceB = null
	while removeCoord.x + posMod < board.brdWd:
		chkPieceA = board.board[removeCoord.y][removeCoord.x + posMod]
		if is_instance_valid(chkPieceA):
			chkPieceA.setState(chkPieceA.DELETE_STATE)
			posMod += 1
			break;
		posMod += 1
	while removeCoord.x - negMod > -1:
		chkPieceB = board.board[removeCoord.y][removeCoord.x - negMod]
		if is_instance_valid(chkPieceB):
			chkPieceB.setState(chkPieceB.DELETE_STATE)
			negMod += 1
			break;
		negMod += 1
	if removeCoord.x + posMod >= board.brdWd and removeCoord.x - negMod <= -1:
		removeSelf()

func setReturnAnimation():
	var returnAnimation = animator.get_animation("returnToButton")
	returnAnimation.track_set_key_value(0, 0, self.position)
	returnAnimation.track_set_key_value(0, 1, button.posNode.global_position)

func alertButton():
	button.displayUsage()

func setBoard(newBoard):
	board = newBoard
	board.boostActive = true

func setButton(newButton):
	button = newButton

func removeSelf():
	board.boostActive = false
	self.queue_free()

func getCoord(pos):
	var brdX = int(floor((pos.x - board.brdX)/board.pieceSize))
	var brdY = int(floor((pos.y - board.brdY)/board.pieceSize))
	var newCoord = Vector2(brdX, brdY)
	return newCoord

func _input(event):
	if event is InputEventMouseButton &&\
	event.is_action_released("ui_select"):
		var coordSelect = getCoord(event.position)
		
		var validMove = false
		for i in range(6):
			var chkPiece = board.board[8][i]
			if is_instance_valid(chkPiece):
				validMove = true
		
		if coordSelect.x < board.brdWd && coordSelect.x >= 0 \
		&& coordSelect.y < board.brdHt && coordSelect.y >= 0 \
		&& is_instance_valid(board.board[coordSelect.y][coordSelect.x])\
		&& not activated && validMove:
			removeCoord = coordSelect
			animator.play("deleteRow")
			sprite.visible = false
		
		elif not activated:
			setReturnAnimation()
			animator.play("returnToButton")
		activated = true
		rowHighlight.visible = false
	
	if event is InputEventMouseMotion and not activated:
		self.position = event.position
		var coordSelect = getCoord(event.position)
		
		var validMove = false
		for i in range(6):
			var chkPiece = board.board[8][i]
			if is_instance_valid(chkPiece):
				validMove = true

		if coordSelect.x < board.brdWd && coordSelect.x >= 0 \
		&& coordSelect.y < board.brdHt && coordSelect.y >= 0 \
		&& is_instance_valid(board.board[coordSelect.y][coordSelect.x])\
		&& not activated && validMove:
			rowHighlight.visible = true
			rowHighlight.global_position =\
			Vector2(board.brdX, board.brdY + (coordSelect.y * board.pieceSize))
		else:
			rowHighlight.visible = false
