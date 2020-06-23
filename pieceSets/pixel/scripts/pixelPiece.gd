extends Node2D

onready var blockAnimation : Node2D = $scalar/block/blockAnimation
onready var tierAnimation : Node2D = $scalar/block/tier/tierAnimation
onready var selectAnimation : Node2D = $scalar/block/select/selectAnimation

#State
const IDLE_STATE = 0
const FALL_STATE = 1
const LAND_STATE = 2
const SPAWN_STATE = 3
const COMBINE_TOP_STATE = 4
const COMBINE_BOT_STATE = 5
const INCREMENT_STATE = 6
const SWITCH_LEFT_STATE = 7
const SWITCH_RIGHT_STATE = 8
var state = SPAWN_STATE

#Selection
const UNSELECTED = 0
const SOLO_SELECTED = 1
const LEFT_SELECTED = 2
const RIGHT_SELECTED = 3
var selState = UNSELECTED

var value = 1
var desPos = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	blockAnimation.connect("animation_finished", self, "_animationEnd")
	blockAnimation.updateValue()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

func isReady():
	return state == IDLE_STATE || state == FALL_STATE

func comparePiece(cmpPiece):
	if cmpPiece == null:
		return -1
	if cmpPiece.getValue() == value:
		return 0
	return 1

func setPos(newPos):
	position = newPos

#Value
func setValue(newVal):
	value = newVal

func getValue():
	return value

#State
func setState(newState):
	state = newState
	blockAnimation.runAnimation()

func getState():
	return state

#Select
func setSelect(newState):
	selState = newState
	selectAnimation.runAnimation()

func getSelect():
	return selState

#Animation
func _animationEnd(animName):
	if animName == "combineTop":
		value += 1
		setState(INCREMENT_STATE)
	elif animName == "combineBot":
		self.queue_free()
	else:
		setState(IDLE_STATE)
