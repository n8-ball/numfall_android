extends CanvasLayer

onready var board : Node2D = $"../.."
onready var background : Node2D = $"../../background"
onready var saveLoad : Node2D = $"../../saveLoad"
onready var achievements : CanvasLayer = $"../../achievements"
onready var confirm : AudioStreamPlayer = $"../confirm"
onready var deny : AudioStreamPlayer = $"../deny"

onready var pieceRoot : Node2D = $"pieceButton/pieceRoot"
onready var musicRoot : Node2D = $"musicButton/musicRoot"
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
	board.changePiece(newTileSet, newSavePiece)

func changeBackground(newBackground, newSaveBackground):
	background.fadeOut()
	background = load(newBackground).instance()
	background.modulate.v = 0.3
	background.modulate.a = 0
	board.add_child(background)
	board.setSaveBackground(newSaveBackground)

func changeMusic(newMusic, newSaveMusic):
	board.changeMusic(newMusic, newSaveMusic)

func setCustomize(pieceName, musicName, backgroundName):
	pieceRoot.setPiece(pieceName)
	musicRoot.setMusic(musicName)
	backgroundRoot.setBackground(backgroundName)

func restartMusic():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), !board.getMusic())
	musicRoot.musicList.unselectPreviews(null)

func _on_done_fading():
	background.fadeIn()
	background.modulate.a = 1
	background.connect("doneFading", self, "_on_done_fading")
