extends Node2D

onready var piece0 : Node2D = $piece0
onready var piece1 : Node2D = $piece1
onready var piece2 : Node2D = $piece2

var curState = 0
var stateExecuted = 5

var timer = 0
var delay = 1

func _ready():
	piece1.setValue(2)
	piece2.setValue(3)
	piece0.setPos(Vector2(100, 800))
	piece2.setPos(Vector2(300, 800))

func _process(delta):
	if curState == 0 && stateExecuted != 0:
		piece0.setState(piece0.IDLE_STATE)
		piece2.setState(piece0.IDLE_STATE)
		stateExecuted = 0
	if curState == 1 && stateExecuted != 1:
		piece0.setState(piece0.SWITCH_LEFT_STATE)
		piece2.setState(piece2.SWITCH_RIGHT_STATE)
		piece0.setPos(Vector2(300, 800))
		piece2.setPos(Vector2(100, 800))
		stateExecuted = 1
	if curState == 2 && stateExecuted != 2:
		piece0.setState(piece0.IDLE_STATE)
		piece2.setState(piece2.IDLE_STATE)
		stateExecuted = 2
	if curState == 3 && stateExecuted != 3:
		piece0.setState(piece0.SWITCH_RIGHT_STATE)
		piece2.setState(piece2.SWITCH_LEFT_STATE)
		piece0.setPos(Vector2(100, 800))
		piece2.setPos(Vector2(300, 800))
		stateExecuted = 3
	if (piece0.getState() == piece0.IDLE_STATE\
	&& curState != 2 && curState != 0):
		curState += 1
	else:
		timer += delta
		if timer > delay:
			timer = 0
			curState += 1
	curState = curState % 4
