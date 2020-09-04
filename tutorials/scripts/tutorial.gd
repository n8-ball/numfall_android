extends CanvasLayer

onready var board : Node2D = $".."
onready var mask : Sprite = $tutorialMask
onready var tutorial0 : Sprite = $tutorial0
onready var tutorial1 : Sprite = $tutorial1
onready var tutorial2 : Sprite = $tutorial2
onready var tutorial3 : Sprite = $tutorial3

var tutorialState = 0
var stateExecuted = 10

var tutorialOpen = true

var stateTimer = 0
var stateDelay = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	board.connect("swapMade", self, "_swapMade")
	restart()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if board.getTutorialStarted():
		if tutorialState == 0:
			state0(delta)
		elif tutorialState == 1:
			state1(delta)
		elif tutorialState == 2:
			state2(delta)
		elif tutorialState == 3:
			state3(delta)
		else:
			tutorialOpen = false
			tutorial0.visible = false
			tutorial1.visible = false
			tutorial2.visible = false
			board.setTutorial(false)
			board.menu.forceSettings()

func state0(delta):
	if board.swapReady:
		get_tree().paused = true
		mask.position = board.getPos(3, 0)
		tutorialOpen = true
		stateTimer += delta
		#On open
		if stateExecuted != 0:
			mask.get_child(0).play("open")
			tutorial0.get_child(0).play("open")
			stateExecuted = 0
		#On close
		if Input.is_action_just_pressed("ui_select") and stateTimer > stateDelay:
			get_tree().paused = false
			tutorial0.get_child(0).play("close")
			mask.get_child(0).play("close")
			tutorialOpen = false
			tutorialState += 1
			stateTimer = 0

func state1(delta):
	if board.swapReady:
		get_tree().paused = false
		mask.position = board.getPos(3, 9)
		tutorialOpen = true
		#On open
		if stateExecuted != 1:
			mask.get_child(0).play("open")
			tutorial1.get_child(0).play("open")
			stateExecuted = 1

func state2(delta):
	if board.swapReady:
		get_tree().paused = true
		mask.position = board.getPos(5, 0)
		tutorialOpen = true
		stateTimer += delta
		#On open
		if stateExecuted != 2:
			mask.get_child(0).play("open")
			tutorial2.get_child(0).play("open")
			stateExecuted = 2
		#On close
		if Input.is_action_just_pressed("ui_select") and stateTimer > stateDelay:
			get_tree().paused = false
			tutorial2.get_child(0).play("close")
			mask.get_child(0).play("close")
			tutorialOpen = false
			tutorialState += 1
			stateTimer = 0

func state3(delta):
	if board.swapReady:
		get_tree().paused = true
		mask.position = board.getPos(5, 9)
		tutorialOpen = true
		stateTimer += delta
		#On open
		if stateExecuted != 3:
			mask.get_child(0).play("open")
			tutorial3.get_child(0).play("open")
			stateExecuted = 3
		#On close
		if Input.is_action_just_pressed("ui_select") and stateTimer > stateDelay:
			tutorial3.get_child(0).play("close")
			mask.get_child(0).play("close")
			tutorialOpen = false
			tutorialState += 1
			stateTimer = 0

func getOpen():
	return tutorialOpen

func restart():
	tutorialState = 0
	tutorialOpen = false
	tutorial0.visible = false
	tutorial1.visible = false
	tutorial2.visible = false
	stateExecuted = 10

func _swapMade():
	if tutorialState == 1:
		tutorialState = 2
		tutorial1.get_child(0).play("close")
		mask.get_child(0).play("close")
		tutorialOpen = false
