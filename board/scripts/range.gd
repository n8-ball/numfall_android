extends Node2D

onready var board : Node2D = $"../.."
onready var spawner : Node2D = $".."

var newPieceName
var floorPiece
var ceilPiece

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if floorPiece != null &&\
		floorPiece.getValue() != spawner.floorNum && floorPiece.isReady():

		floorPiece.setValue(spawner.floorNum)
		floorPiece.setState(floorPiece.INCREMENT_STATE)

	if ceilPiece != null &&\
		ceilPiece.getValue() != spawner.ceilNum && ceilPiece.isReady():

		ceilPiece.setValue(spawner.ceilNum)
		ceilPiece.setState(ceilPiece.INCREMENT_STATE)

func clearRange():
	if floorPiece != null:
		floorPiece.setState(floorPiece.DELETE_STATE)
	if ceilPiece != null:
		ceilPiece.setState(ceilPiece.DELETE_STATE)
	
	floorPiece = null
	ceilPiece = null

func newRange():
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
