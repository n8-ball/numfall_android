extends CanvasLayer

onready var board : Node2D = $".."
onready var animator : AnimationPlayer = $animator
onready var maskSquare : Sprite = $maskSquare
#Situational
onready var scoringTut : Sprite = $scoring
onready var comboTut : Sprite = $combo
onready var rangeArrowTut : Sprite = $rangeArrow


var tutorialState = 0
var tutorialOpen = false

# Called when the node enters the scene tree for the first time.
func _ready():
	board.connect("swapMade", self, "_swapMade")
	board.connect("combo", self, "_onCombo")
	restart()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if board.getTutorialStarted():
		if tutorialState == 0:
			introduction()
		elif tutorialState == 1:
			swiping()
		elif tutorialState == 2:
			drops()
		elif tutorialState == 3:
			rangeTut()
		elif tutorialState == 4:
			boosts()
		elif tutorialState == 5 or tutorialState == 6:
			scoring()
		elif tutorialState == 7:
			pass
		elif tutorialState == 8:
			combo()
		elif tutorialState == 9:
			rangeArrow()
		else:
			tutorialOpen = false
			board.setTutorial(false)
			board.menu.forceSettings()
#
func introduction():
	if board.swapReady:
		get_tree().paused = true
		if tutorialOpen == false:
			tutorialOpen = true
			animator.queue("introduction")
		#On close
		if Input.is_action_just_pressed("ui_select") and animator.current_animation == "":
			get_tree().paused = false
			animator.play_backwards("introduction")
			tutorialOpen = false
			tutorialState = 1

func swiping():
	if board.swapReady && animator.current_animation == "":
		if tutorialOpen == false:
			tutorialOpen = true
			animator.queue("swiping")

func drops():
	if board.swapReady:
		get_tree().paused = true
		if tutorialOpen == false:
			tutorialOpen = true
			animator.queue("drops")
		#On close
		if Input.is_action_just_pressed("ui_select") and animator.current_animation == "":
			get_tree().paused = false
			animator.play_backwards("drops")
			tutorialOpen = false
			tutorialState = 3

func rangeTut():
	if board.swapReady and animator.current_animation == "":
		get_tree().paused = true
		if tutorialOpen == false:
			tutorialOpen = true
			animator.queue("range")
		#On close
		if Input.is_action_just_pressed("ui_select"):
			get_tree().paused = false
			animator.play_backwards("range")
			tutorialOpen = false
			tutorialState = 4

func boosts():
	if board.swapReady and animator.current_animation == "":
		get_tree().paused = true
		if tutorialOpen == false:
			tutorialOpen = true
			animator.queue("boosts")
		#On close
		if Input.is_action_just_pressed("ui_select"):
			get_tree().paused = false
			animator.play_backwards("boosts")
			tutorialOpen = false
			tutorialState = 5

func scoring():
	var scorablePiece = findScorable()
	if board.swapReady and animator.current_animation == "" and scorablePiece != null:
		if tutorialOpen == false:
			tutorialState = 6
			tutorialOpen = true
			setScoringAnimation(scorablePiece)
			animator.queue("scoring")

func combo():
	if animator.current_animation == "":
		get_tree().paused = true
	if Input.is_action_just_pressed("ui_select") and animator.current_animation == "":
		get_tree().paused = false
		animator.play_backwards("combo")
		tutorialOpen = false
		tutorialState = 9

func rangeArrow():
	if  board.spawner.rangeDisplay.upgradeArrow.visible == true:
		get_tree().paused = true
		if tutorialOpen == false:
			tutorialOpen = true
			animator.queue("rangeArrow")
		#On close
		if Input.is_action_just_pressed("ui_select") and animator.current_animation == "":
			get_tree().paused = false
			animator.play_backwards("rangeArrow")
			tutorialOpen = false
			tutorialState = 10

func setScoringAnimation(piecePosition):
	var curvedArrow = scoringTut.find_node("tutorialCurvedArrow")
	var straightArrow = scoringTut.find_node("tutorialStraightArrow")
	scoringTut.position = Vector2(720, 1500 - (200 * (9 - piecePosition.y)))
	maskSquare.position = board.getPos(piecePosition.x, piecePosition.y)
	if piecePosition.x < 3:
		curvedArrow.visible = false
		straightArrow.visible = true
		if piecePosition.x == 0:
			scoringTut.position = Vector2(600, 1550 - (200 * (9 - piecePosition.y)))
			straightArrow.position.x = -300
		if piecePosition.x == 1:
			scoringTut.position = Vector2(720, 1550 - (200 * (9 - piecePosition.y)))
			straightArrow.position.x = -250
		if piecePosition.x == 2:
			scoringTut.position = Vector2(720, 1550 - (200 * (9 - piecePosition.y)))
			straightArrow.position.x = -50
	else:
		curvedArrow.visible = true
		straightArrow.visible = false
		if piecePosition.x == 3:
			scoringTut.position = Vector2(720, 1550 - (200 * (9 - piecePosition.y)))
			curvedArrow.position.x = 25
		if piecePosition.x == 4:
			scoringTut.position = Vector2(720, 1550 - (200 * (9 - piecePosition.y)))
			curvedArrow.position.x = 225
		if piecePosition.x == 5:
			scoringTut.position = Vector2(840, 1550 - (200 * (9 - piecePosition.y)))
			curvedArrow.position.x = 300
		

func findScorable():
	for x in range(board.brdWd):
		if board.board[0][x] != null:
			return null
	for y in range(board.brdHt - 2, 0, -1):
		for x in range(board.brdWd):
			var curPiece = board.board[y][x]
			var rightPiece = null
			var leftPiece = null
			if x > 0:
				leftPiece = board.board[y + 1][x - 1]
				if is_instance_valid(curPiece) and is_instance_valid(leftPiece):
					if curPiece.value == leftPiece.value:
						return Vector2(x, y)
			if x < board.brdWd - 1:
				rightPiece = board.board[y + 1][x + 1]
				if is_instance_valid(curPiece) and is_instance_valid(rightPiece):
					if curPiece.value == rightPiece.value:
						return Vector2(x, y)
	return null

func setComboAnimation(piecePosition):
	var curvedArrow = comboTut.find_node("tutorialCurvedArrow")
	var straightArrow = comboTut.find_node("tutorialStraightArrow")
	comboTut.position = Vector2(720, 1500 - (200 * (9 - piecePosition.y)))
	maskSquare.position = board.getPos(piecePosition.x, piecePosition.y)
	if piecePosition.x < 3:
		curvedArrow.visible = false
		straightArrow.visible = true
		if piecePosition.x == 0:
			comboTut.position = Vector2(600, 1550 - (200 * (9 - piecePosition.y)))
			straightArrow.position.x = -300
		if piecePosition.x == 1:
			comboTut.position = Vector2(720, 1550 - (200 * (9 - piecePosition.y)))
			straightArrow.position.x = -250
		if piecePosition.x == 2:
			comboTut.position = Vector2(720, 1550 - (200 * (9 - piecePosition.y)))
			straightArrow.position.x = -50
	else:
		curvedArrow.visible = true
		straightArrow.visible = false
		if piecePosition.x == 3:
			comboTut.position = Vector2(720, 1550 - (200 * (9 - piecePosition.y)))
			curvedArrow.position.x = 25
		if piecePosition.x == 4:
			comboTut.position = Vector2(720, 1550 - (200 * (9 - piecePosition.y)))
			curvedArrow.position.x = 225
		if piecePosition.x == 5:
			comboTut.position = Vector2(840, 1550 - (200 * (9 - piecePosition.y)))
			curvedArrow.position.x = 300

func getOpen():
	return tutorialOpen
#
func restart():
	tutorialState = 0
	tutorialOpen = false

func _swapMade():
	if board.getTutorialStarted():
		if tutorialState == 1:
			tutorialState = 2
			animator.play_backwards("swiping")
			tutorialOpen = false
		if tutorialState == 6:
			tutorialState = 7
			animator.play_backwards("scoring")
			tutorialOpen = false

func _onCombo(position):
	if board.getTutorialStarted():
		if tutorialState == 7:
			if tutorialOpen == false:
				tutorialState = 8
				tutorialOpen = true
				setComboAnimation(position)
				animator.queue("combo")
