extends CanvasLayer

onready var board : Node2D = $".."
onready var musicButton : TextureButton = $musicButton
onready var soundButton : TextureButton = $soundButton

var open = true

const gameOverOffset = 2560

func _process(delta):
	get_tree().paused = getOpen()

func forceSettings():
	musicButton.setMusic(board.getMusic())
	soundButton.setSound(board.getSound())

func getOpen():
	return open

func setOpen(newOpen):
	open = newOpen

func endGameMenu():
	open = true
	self.offset.y = gameOverOffset
