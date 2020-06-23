extends CanvasLayer

onready var board : Node2D = $".."

var open = true

func _process(delta):
	get_tree().paused = getOpen()

func getOpen():
	return open

func setOpen(newOpen):
	open = newOpen

func restartGame():
	board.restartGame()
