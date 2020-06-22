extends Node2D

onready var board : Node2D = $"../.."
onready var spawner : Node2D = $".."

var newPieceName
var floorPiece
var ceilPiece

# Called when the node enters the scene tree for the first time.
func _ready():
	newPieceName = board.getPieceType()
	
	floorPiece = newPieceName.instance()
	floorPiece.setValue(spawner.floorNum)
	add_child(floorPiece)
	floorPiece.setState(floorPiece.SPAWN_STATE)
	floorPiece.setPos(Vector2(board.pieceSize * 3, board.pieceSize))
	
	ceilPiece = newPieceName.instance()
	ceilPiece.setValue(spawner.ceilNum)
	add_child(ceilPiece)
	ceilPiece.setState(ceilPiece.SPAWN_STATE)
	ceilPiece.setPos(Vector2(board.pieceSize * 4, board.pieceSize))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if floorPiece.getValue() < spawner.floorNum && floorPiece.isReady():
		floorPiece.setValue(floorPiece.getValue() + 1)
		floorPiece.setState(floorPiece.INCREMENT_STATE)
	if ceilPiece.getValue() < spawner.ceilNum && ceilPiece.isReady():
		ceilPiece.setValue(ceilPiece.getValue() + 1)
		ceilPiece.setState(ceilPiece.INCREMENT_STATE)
