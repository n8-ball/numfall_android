extends Node2D

onready var colHighlight : Sprite = $"colHighlight"
onready var sprite : Sprite = $"sprite"
onready var animator : AnimationPlayer = $"animator"
onready var confirm : AudioStreamPlayer = $"confirm"
onready var deny : AudioStreamPlayer = $"deny"


var board
var button

var activated = false
var removeCoord = null
var coordMod = 0

func deletePiece():
	var chkPiece = null
	while coordMod < board.brdHt:
		chkPiece = board.board[coordMod][removeCoord.x]
		if is_instance_valid(chkPiece):
			chkPiece.setState(chkPiece.DELETE_STATE)
			coordMod += 1
			break;
		coordMod += 1
	if coordMod >= board.brdHt:
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
			var chkPiece = board.board[9][i]
			if is_instance_valid(chkPiece) and i != coordSelect.x:
				validMove = true
		
		if coordSelect.x < board.brdWd && coordSelect.x >= 0 \
		&& coordSelect.y < board.brdHt && coordSelect.y >= 0 \
		&& is_instance_valid(board.board[coordSelect.y][coordSelect.x])\
		&& not activated && validMove:
			removeCoord = coordSelect
			animator.play("deleteRow")
			sprite.visible = false
			board.colBoosts -= 1
		
		elif not activated:
			setReturnAnimation()
			animator.play("returnToButton")
		activated = true
		colHighlight.visible = false
	
	if event is InputEventMouseMotion and not activated:
		self.position = event.position
		var coordSelect = getCoord(event.position)
		
		var validMove = false
		for i in range(6):
			var chkPiece = board.board[9][i]
			if is_instance_valid(chkPiece) and i != coordSelect.x:
				validMove = true

		if coordSelect.x < board.brdWd && coordSelect.x >= 0 \
		&& coordSelect.y < board.brdHt && coordSelect.y >= 0 \
		&& is_instance_valid(board.board[coordSelect.y][coordSelect.x])\
		&& not activated && validMove:
			colHighlight.visible = true
			colHighlight.global_position =\
			Vector2(board.brdX + (coordSelect.x * board.pieceSize), board.brdY)
		else:
			colHighlight.visible = false
