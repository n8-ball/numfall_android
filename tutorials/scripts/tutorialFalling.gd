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

func _process(delta):
	if curState == 0 && stateExecuted != 0:
		piece0.setPos(Vector2(100, 200))
		piece0.setState(piece0.SPAWN_STATE)
		piece2.setPos(Vector2(300, 200))
		piece2.setState(piece0.SPAWN_STATE)
		stateExecuted = 0
	if curState == 1 && stateExecuted != 1:
		piece0.setPos(Vector2(100, 200))
		piece0.setState(piece0.FALL_STATE)
		piece2.setPos(Vector2(300, 200))
		piece2.setState(piece0.FALL_STATE)
		stateExecuted = 1
	if curState == 2 && stateExecuted != 2:
		piece0.setPos(Vector2(100, 400))
		piece0.setState(piece0.FALL_STATE)
		piece2.setPos(Vector2(300, 400))
		piece2.setState(piece0.FALL_STATE)
		stateExecuted = 2
	if curState == 3 && stateExecuted != 3:
		piece0.setPos(Vector2(100, 600))
		piece0.setState(piece0.FALL_STATE)
		piece2.setPos(Vector2(300, 600))
		piece2.setState(piece0.LAND_STATE)
		stateExecuted = 3
	if curState == 4 && stateExecuted != 4:
		piece0.setPos(Vector2(100, 800))
		piece0.setState(piece0.LAND_STATE)
		stateExecuted = 4
	if curState == 5 && stateExecuted != 5:
		piece0.setState(piece0.IDLE_STATE)
		stateExecuted = 5
	if (piece0.getState() == piece0.IDLE_STATE\
	|| piece0.getState() == piece0.FALL_STATE) && curState != 5:
		curState += 1
	else:
		timer += delta
		if timer > delay:
			timer = 0
			curState = 0
