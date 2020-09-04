extends CanvasLayer

onready var board : Node2D = $".."
onready var overlay : ColorRect = $overlay
onready var musicButton : TextureButton = $musicButton
onready var soundButton : TextureButton = $soundButton
onready var tutorialButton : TextureButton = $tutorialButton

var open = true

const gameOverOffset = 2560

var gameOverStart = false
var gameOverTimer = 0.01
const gameOverDelay = 1.5


func _process(delta):
	get_tree().paused = getOpen()
	if gameOverStart:
		gameOverTimer += delta
		if gameOverTimer > gameOverDelay:
			gameOverStart = false
			open = true
			gameOverTimer = 0.01

func forceSettings():
	musicButton.setMusic(board.getMusic())
	soundButton.setSound(board.getSound())
	tutorialButton.setTutorial(board.getTutorial())

func getOpen():
	return open

func setOpen(newOpen):
	open = newOpen

func endGameMenu():
	gameOverStart = true
	self.offset.y = gameOverOffset
