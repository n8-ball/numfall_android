extends Node2D

onready var board : Node2D = $".."
onready var animator : AnimationPlayer = $"animator"


var deleteList = []

func _ready():
	animator.connect("animation_finished", self, "_on_finished")

func continueBoost():
	var deleteCount = 0
	var pieceMinimum = board.spawner.floorNum
	board.boostActive = true
	deleteList = []
	var deleteAnimation = animator.get_animation("delete")
	while deleteCount < 15:
		for y in range(board.brdHt - 1, -1, -1):
			for x in range(board.brdWd):
				var curPiece = board.board[y][x]
				if is_instance_valid(curPiece) and curPiece.value == pieceMinimum\
				&& deleteCount < 15:
					var randX = rand_range(-50, 50)
					var randY = rand_range(-50, 50)
					deleteAnimation.track_set_key_value(1, 2 * deleteCount + 1, board.getPos(x, y) - Vector2(randX, 100 + randY))
					deleteAnimation.track_set_key_value(1, 2 * deleteCount + 2, board.getPos(x, y) - Vector2(randX, 100 + randY))
					deleteCount += 1
					deleteList.append(Vector2(x, y))
		pieceMinimum += 1
	animator.play("delete")

func deletePiece(i):
	var curPiece = board.board[deleteList[i].y][deleteList[i].x]
	if is_instance_valid(curPiece):
		curPiece.setState(curPiece.DELETE_STATE)

func resumeGame():
	board.setGameOver(false)
	board.saveReady = true
	board.saveLoad.saveGame()
	board.boostActive = false

func _on_finished(animation):
	if animation == "delete":
		resumeGame()
