extends CanvasLayer

onready var board : Node2D = $".."
onready var background : Node2D = $"../background"
onready var root : Node2D = $root
onready var saveLoad : Node2D = $"../saveLoad"

var open = false
var changingBackground = false
var backgroundFade = 1
var fadeRate = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	background.connect("doneFading", self, "_on_done_fading")

func setOpen(newOpen):
	open = newOpen
	root.visible = open

func getOpen():
	return open

func changeTileSet(newTileSet):
	board.changePiece(newTileSet)
	saveLoad.loadBoard()

func changeBackground(newBackground):
	background.fadeOut()
	background = newBackground.instance()
	background.modulate.v = 0.3
	background.modulate.a = 0
	board.add_child(background)

func _on_done_fading():
	background.fadeIn()
	background.modulate.a = 1
	background.connect("doneFading", self, "_on_done_fading")

