extends Node2D

onready var confirm : AudioStreamPlayer = $"confirm"
onready var deny : AudioStreamPlayer = $"deny"
onready var sprite : Sprite = $"sprite"

var board
var button

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
		&& not scheduleDelete && validMove:
			confirm.play()
			for i in range(10):
				var chkPiece = board.board[i][coordSelect.x]
				if is_instance_valid(chkPiece):
					chkPiece.setState(chkPiece.DELETE_STATE)
		elif not scheduleDelete:
			deny.play()
			button.displayUsage()
		sprite.visible = false
		scheduleDelete = true
	
	if event is InputEventMouseMotion:
		self.position = event.position

func _delete():
	self.queue_free()
