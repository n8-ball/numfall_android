extends CanvasLayer

onready var board : Node2D = $".."
onready var musicButton : TextureButton = $musicButton
onready var soundButton : TextureButton = $soundButton

var open = true

func _process(delta):
	get_tree().paused = getOpen()

func forceSettings():
	musicButton.setMusic(board.getMusic())
	soundButton.setSound(board.getSound())

func getOpen():
	return open

func setOpen(newOpen):
	open = newOpen
