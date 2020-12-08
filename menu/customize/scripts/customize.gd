extends CanvasLayer

onready var board : Node2D = $"../.."
onready var background : Node2D = $"../../background"
onready var saveLoad : Node2D = $"../../saveLoad"
onready var achievements : CanvasLayer = $"../../achievements"
onready var confirm : AudioStreamPlayer2D = $"../../menu/confirm"
onready var deny : AudioStreamPlayer2D = $"../../menu/deny"

onready var pieceRoot : Node2D = $"pieceButton/pieceRoot"
#onready var musicRoot : Node2D = $"musicButton/musicRoot"
onready var backgroundRoot : Node2D = $"backgroundButton/backgroundRoot"

var changingBackground = false
var backgroundFade = 1
var fadeRate = 1

var achievementDict = null

# Called when the node enters the scene tree for the first time.
func _ready():
	background.connect("doneFading", self, "_on_done_fading")
	achievementDict = achievements.getAchievements()

func changeTileSet(newTileSet, newSavePiece):
	confirm.playSound()
	board.changePiece(newTileSet, newSavePiece)

func changeBackground(newBackground, newSaveBackground):
	confirm.playSound()
	background.fadeOut()
	background = load(newBackground).instance()
	background.modulate.v = 0.3
	background.modulate.a = 0
	board.add_child(background)
	board.setSaveBackground(newSaveBackground)

func setCustomize(pieceName, musicName, backgroundName):
	pieceRoot.setPiece(pieceName)
	#musicRoot.setMusic(musicName)
	backgroundRoot.setBackground(backgroundName)

func _on_done_fading():
	background.fadeIn()
	background.modulate.a = 1
	background.connect("doneFading", self, "_on_done_fading")
