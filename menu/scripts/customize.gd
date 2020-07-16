extends CanvasLayer

onready var board : Node2D = $".."
onready var saveLoad : Node2D = $"../saveLoad"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func changeTileSet(newTileSet):
	board.changePiece(newTileSet)
	saveLoad.loadBoard()

func changeBackground(newBackground):
	pass
