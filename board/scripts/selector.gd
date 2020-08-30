extends Node2D

onready var board : Node2D = $".."

#Selection
var select = null
var coordSelect = Vector2(-1, -1)
var justClicked = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func getCoord(pos):
	var brdX = int(floor((pos.x - board.brdX)/board.pieceSize))
	var brdY = int(floor((pos.y - board.brdY)/board.pieceSize))
	var newCoord = Vector2(brdX, brdY)
	return newCoord

func _input(event):
	#Select First
	if event is InputEventMouseButton && event.is_action_pressed("ui_select")\
	&& !justClicked: #&& board.swapReady:
		justClicked = true
		coordSelect = getCoord(event.position)
		if coordSelect.x < board.brdWd && coordSelect.x >= 0 \
		&& coordSelect.y < board.brdHt && coordSelect.y >= 0:
			select = board.board[coordSelect.y][coordSelect.x]
			if nodeAvailable(select) && select.getState() == select.IDLE_STATE:
				select.setSelect(select.SOLO_SELECTED)
			else:
				select = null
	
	elif event is InputEventMouseMotion && nodeAvailable(select)\
	&& board.swapReady && !board.getGameOver():
		if getCoord(event.position).x < board.brdWd\
		&& getCoord(event.position).x >= 0:
			#Right
			if event.position.x > board.getPos(coordSelect.x + 1, 0).x:
				select.setSelect(select.UNSELECTED)
				board.swapPieces(coordSelect, coordSelect + Vector2(1, 0))
				select = null
				coordSelect = Vector2(-1, -1)
			#Left
			elif event.position.x < board.getPos(coordSelect.x - 1, 0).x:
				select.setSelect(select.UNSELECTED)
				board.swapPieces(coordSelect, coordSelect + Vector2(-1, 0))
				select = null
				coordSelect = Vector2(-1, -1)
	#Unselect
	elif event is InputEventMouseButton &&\
	event.is_action_released("ui_select"):
		justClicked = false
		clearSelect()

func clearSelect():
	if nodeAvailable(select):
		select.setSelect(select.UNSELECTED)
	select = null
	coordSelect = Vector2(-1, -1)

func nodeAvailable(node):
	if node == null:
	  return false
	var ref = weakref(node).get_ref()
	if ref == null:
	  return false
	if ref.is_queued_for_deletion():
	  return false
	return true
