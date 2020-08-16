extends CanvasLayer

onready var board : Node2D = $".."
onready var background : Node2D = $"../background"
onready var root : Control = $root
onready var saveLoad : Node2D = $"../saveLoad"
onready var achievements : CanvasLayer = $"../achievements"

var open = false
var changingBackground = false
var backgroundFade = 1
var fadeRate = 1

var achievementDict = null

# Called when the node enters the scene tree for the first time.
func _ready():
	background.connect("doneFading", self, "_on_done_fading")
	root.visible = open

func setOpen(newOpen):
	achievementDict = achievements.getAchievements()
	open = newOpen
	root.visible = open

func getOpen():
	return open

func changeTileSet(newTileSet):
	board.changePiece(newTileSet)

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

