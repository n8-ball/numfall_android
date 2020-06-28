extends CanvasLayer

onready var board : Node2D = $".."

var open = true

func _process(delta):
	get_tree().paused = getOpen()

func getMusic():
	return board.getMusic()

func setMusic(newMusic):
	board.setMusic(newMusic)

func getOpen():
	return open

func setOpen(newOpen):
	open = newOpen

func restartGame():
	board.restartGame()
