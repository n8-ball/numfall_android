extends Node2D

onready var pieceButton : TextureButton = $".."
onready var pieceList : GridContainer = $"pieceList"
onready var customize : CanvasLayer = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.visible = pieceButton.getPressed()

func changeResource(newResourceName, newPieceName):
	customize.changeTileSet(newResourceName, newPieceName)

func setPiece(pieceName):
	pieceList.setItem(pieceName)
